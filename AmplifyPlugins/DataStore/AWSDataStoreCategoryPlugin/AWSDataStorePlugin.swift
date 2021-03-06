//
// Copyright 2018-2020 Amazon.com,
// Inc. or its affiliates. All Rights Reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Amplify
import Combine

final public class AWSDataStorePlugin: DataStoreCategoryPlugin {

    public var key: PluginKey = "awsDataStorePlugin"

    /// `true` if any models are syncable. Resolved during configuration phase
    var isSyncEnabled: Bool

    /// The Publisher that sends mutation events to subscribers
    let dataStorePublisher: DataStoreSubscribeBehavior?

    let modelRegistration: AmplifyModelRegistration

    /// The local storage provider. Resolved during configuration phase
    var storageEngine: StorageEngineBehavior!

    var iStorageEngineSink: Any?
    @available(iOS 13.0, *)
    var storageEngineSink: AnyCancellable? {
        get {
            if let iStorageEngineSink = iStorageEngineSink as? AnyCancellable {
                return iStorageEngineSink
            }
            return nil
        }
        set {
            iStorageEngineSink = newValue
        }
    }

    /// No-argument init that uses defaults for all providers
    public init(modelRegistration: AmplifyModelRegistration) {
        self.modelRegistration = modelRegistration
        self.isSyncEnabled = false
        if #available(iOS 13.0, *) {
            self.dataStorePublisher = DataStorePublisher()
        } else {
            self.dataStorePublisher = nil
        }
    }

    /// Internal initializer for testing
    init(modelRegistration: AmplifyModelRegistration,
         storageEngine: StorageEngineBehavior,
         dataStorePublisher: DataStoreSubscribeBehavior) {
        self.modelRegistration = modelRegistration
        self.isSyncEnabled = false
        self.storageEngine = storageEngine
        self.dataStorePublisher = dataStorePublisher
    }

    /// By the time this method gets called, DataStore will already have invoked
    /// `AmplifyModelRegistration.registerModels`, so we can inspect those models to derive isSyncEnabled, and pass
    /// them to `StorageEngine.setUp(models:)`
    public func configure(using configuration: Any) throws {
        modelRegistration.registerModels(registry: ModelRegistry.self)
        resolveSyncEnabled()
        try resolveStorageEngine()

        try storageEngine.setUp(models: ModelRegistry.models)

        let filter = HubFilters.forEventName(HubPayload.EventName.Amplify.configured)
        var token: UnsubscribeToken?
        token = Amplify.Hub.listen(to: .dataStore, isIncluded: filter) { _ in
            self.storageEngine.startSync()
            if let token = token {
                Amplify.Hub.removeListener(token)
            }
        }
    }

    // MARK: Private

    private func resolveSyncEnabled() {
        if #available(iOS 13.0, *) {
            isSyncEnabled = ModelRegistry.hasSyncableModels
        }
    }

    private func resolveStorageEngine() throws {
        guard storageEngine == nil else {
            return
        }

        storageEngine = try StorageEngine(isSyncEnabled: isSyncEnabled)
        if #available(iOS 13.0, *) {
            setupStorageSink()
        }
    }

    @available(iOS 13.0, *)
    private func setupStorageSink() {
        storageEngineSink = storageEngine.publisher.sink(receiveCompletion: onReceiveCompletion(completed:),
                                                         receiveValue: onRecieveValue(receiveValue:))
    }

    @available(iOS 13.0, *)
    private func onReceiveCompletion(completed: Subscribers.Completion<DataStoreError>) {
        guard let dataStorePublisher = self.dataStorePublisher as? DataStorePublisher else {
            log.error("Data store publisher not initalized")
            return
        }
        switch completed {
        case .failure(let dataStoreError):
            dataStorePublisher.send(dataStoreError: dataStoreError)
        case .finished:
            dataStorePublisher.sendFinished()
        }
    }

    @available(iOS 13.0, *)
    private func onRecieveValue(receiveValue: StorageEngineEvent) {
        guard let dataStorePublisher = self.dataStorePublisher as? DataStorePublisher else {
            log.error("Data store publisher not initalized")
            return
        }

        if case .mutationEvent(let mutationEvent) = receiveValue {
            dataStorePublisher.send(input: mutationEvent)
        }
    }

    public func reset(onComplete: @escaping (() -> Void)) {
        let group = DispatchGroup()
        if let resettable = storageEngine as? Resettable {
            group.enter()
            DispatchQueue.global().async {
                resettable.reset {
                    group.leave()
                }
            }
        }

        group.wait()
        onComplete()
    }

}
