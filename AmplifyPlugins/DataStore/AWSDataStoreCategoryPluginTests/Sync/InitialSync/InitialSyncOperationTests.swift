//
// Copyright 2018-2020 Amazon.com,
// Inc. or its affiliates. All Rights Reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import XCTest
import SQLite

@testable import Amplify
@testable import AmplifyTestCommon
@testable import AWSDataStoreCategoryPlugin
@testable import AWSPluginsCore

class InitialSyncOperationTests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
    }

    /// - Given: An InitialSyncOperation
    /// - When:
    ///    - I invoke main()
    /// - Then:
    ///    - It reads sync metadata from storage
    func testReadsMetadata() {
        let responder = QueryRequestListenerResponder<PaginatedList<AnyModel>> { _, listener in
            let startedAt = Int(Date().timeIntervalSince1970)
            let list = PaginatedList<AnyModel>(items: [], nextToken: nil, startedAt: startedAt)
            let event: GraphQLOperation<PaginatedList<AnyModel>>.Event = .completed(.success(list))
            listener?(event)
            return nil
        }

        let apiPlugin = MockAPICategoryPlugin()
        apiPlugin.responders[.queryRequestListener] = responder

        let storageAdapter = MockSQLiteStorageEngineAdapter()
        let metadataQueryReceived = expectation(description: "Metadata query received by storage adapter")
        storageAdapter.returnOnQueryModelSyncMetadata(nil) {
            metadataQueryReceived.fulfill()
        }

        let reconciliationQueue = MockReconciliationQueue()
        let operation = InitialSyncOperation(
            modelType: MockSynced.self,
            api: apiPlugin,
            reconciliationQueue: reconciliationQueue,
            storageAdapter: storageAdapter) { _ in }

        operation.main()

        wait(for: [metadataQueryReceived], timeout: 1.0)
    }

    /// - Given: An InitialSyncOperation
    /// - When:
    ///    - I invoke main()
    /// - Then:
    ///    - It performs a sync query against the API category
    func testQueriesAPI() {
        let apiWasQueried = expectation(description: "API was queried for a PaginatedList of AnyModel")
        let responder = QueryRequestListenerResponder<PaginatedList<AnyModel>> { _, listener in
            let startedAt = Int(Date().timeIntervalSince1970)
            let list = PaginatedList<AnyModel>(items: [], nextToken: nil, startedAt: startedAt)
            let event: GraphQLOperation<PaginatedList<AnyModel>>.Event = .completed(.success(list))
            listener?(event)
            apiWasQueried.fulfill()
            return nil
        }

        let apiPlugin = MockAPICategoryPlugin()
        apiPlugin.responders[.queryRequestListener] = responder

        let storageAdapter = MockSQLiteStorageEngineAdapter()
        storageAdapter.returnOnQueryModelSyncMetadata(nil)

        let reconciliationQueue = MockReconciliationQueue()
        let operation = InitialSyncOperation(
            modelType: MockSynced.self,
            api: apiPlugin,
            reconciliationQueue: reconciliationQueue,
            storageAdapter: storageAdapter) { _ in }

        operation.main()

        wait(for: [apiWasQueried], timeout: 1.0)
    }

    /// - Given: An InitialSyncOperation
    /// - When:
    ///    - I invoke main()
    /// - Then:
    ///    - The method invokes a completion callback when complete
    func testInvokesCompletionCallback() {
        let responder = QueryRequestListenerResponder<PaginatedList<AnyModel>> { _, listener in
            let startedAt = Int(Date().timeIntervalSince1970)
            let list = PaginatedList<AnyModel>(items: [], nextToken: nil, startedAt: startedAt)
            let event: GraphQLOperation<PaginatedList<AnyModel>>.Event = .completed(.success(list))
            listener?(event)
            return nil
        }

        let apiPlugin = MockAPICategoryPlugin()
        apiPlugin.responders[.queryRequestListener] = responder

        let storageAdapter = MockSQLiteStorageEngineAdapter()
        storageAdapter.returnOnQueryModelSyncMetadata(nil)

        let reconciliationQueue = MockReconciliationQueue()
        let syncCallbackReceived = expectation(description: "Sync callback received, sync operation is complete")
        let operation = InitialSyncOperation(
            modelType: MockSynced.self,
            api: apiPlugin,
            reconciliationQueue: reconciliationQueue,
            storageAdapter: storageAdapter) { _ in
                syncCallbackReceived.fulfill()
        }

        operation.main()

        wait(for: [syncCallbackReceived], timeout: 1.0)
    }

    /// - Given: An InitialSyncOperation
    /// - When:
    ///    - I invoke main() against an API that returns paginated data
    /// - Then:
    ///    - The method invokes a completion callback
    func testRetrievesPaginatedData() {
        let apiWasQueried = expectation(description: "API was queried for a PaginatedList of AnyModel")
        apiWasQueried.expectedFulfillmentCount = 3

        var nextTokens = ["token1", "token2"]

        let responder = QueryRequestListenerResponder<PaginatedList<AnyModel>> { _, listener in
            let startedAt = Int(Date().timeIntervalSince1970)
            let nextToken = nextTokens.isEmpty ? nil : nextTokens.removeFirst()
            let list = PaginatedList<AnyModel>(items: [], nextToken: nextToken, startedAt: startedAt)
            let event: GraphQLOperation<PaginatedList<AnyModel>>.Event = .completed(.success(list))
            listener?(event)
            apiWasQueried.fulfill()
            return nil
        }

        let apiPlugin = MockAPICategoryPlugin()
        apiPlugin.responders[.queryRequestListener] = responder

        let storageAdapter = MockSQLiteStorageEngineAdapter()
        storageAdapter.returnOnQueryModelSyncMetadata(nil)

        let reconciliationQueue = MockReconciliationQueue()
        let operation = InitialSyncOperation(
            modelType: MockSynced.self,
            api: apiPlugin,
            reconciliationQueue: reconciliationQueue,
            storageAdapter: storageAdapter) { _ in }

        operation.main()

        wait(for: [apiWasQueried], timeout: 1.0)
    }

    /// - Given: An InitialSyncOperation
    /// - When:
    ///    - I invoke main() against an API that returns data
    /// - Then:
    ///    - The method submits the returned data to the reconciliation queue
    func testSubmitsToReconciliationQueue() {
        let responder = QueryRequestListenerResponder<PaginatedList<AnyModel>> { _, listener in
            let startedAt = Int(Date().timeIntervalSince1970)
            let model = MockSynced(id: "1")
            let anyModel = AnyModel(model)
            let metadata = MutationSyncMetadata(id: "1",
                                                deleted: false,
                                                lastChangedAt: Int(Date().timeIntervalSince1970),
                                                version: 1)
            let mutationSync = MutationSync(model: anyModel, syncMetadata: metadata)
            let list = PaginatedList<AnyModel>(items: [mutationSync], nextToken: nil, startedAt: startedAt)
            let event: GraphQLOperation<PaginatedList<AnyModel>>.Event = .completed(.success(list))
            listener?(event)
            return nil
        }

        let apiPlugin = MockAPICategoryPlugin()
        apiPlugin.responders[.queryRequestListener] = responder

        let storageAdapter = MockSQLiteStorageEngineAdapter()
        storageAdapter.returnOnQueryModelSyncMetadata(nil)

        let itemSubmitted = expectation(description: "Item submitted to reconciliation queue")
        let reconciliationQueue = MockReconciliationQueue()
        reconciliationQueue.listeners.append { message in
            if message.hasPrefix("offer(_:)")
                && message.contains("MutationSync<AnyModel>")
                && message.contains(#"id: "1"#) {
                itemSubmitted.fulfill()
            }
        }

        let operation = InitialSyncOperation(
            modelType: MockSynced.self,
            api: apiPlugin,
            reconciliationQueue: reconciliationQueue,
            storageAdapter: storageAdapter) { _ in }

        operation.main()

        wait(for: [itemSubmitted], timeout: 1.0)
    }

    /// - Given: An InitialSyncOperation
    /// - When:
    ///    - I invoke main() against an API that returns data
    /// - Then:
    ///    - The method submits the returned data to the reconciliation queue
    func testUpdatesSyncMetadata() throws {
        let startDateSeconds = Int(Date().timeIntervalSince1970)
        let responder = QueryRequestListenerResponder<PaginatedList<AnyModel>> { _, listener in
            let startedAt = startDateSeconds
            let list = PaginatedList<AnyModel>(items: [], nextToken: nil, startedAt: startedAt)
            let event: GraphQLOperation<PaginatedList<AnyModel>>.Event = .completed(.success(list))
            listener?(event)
            return nil
        }

        let apiPlugin = MockAPICategoryPlugin()
        apiPlugin.responders[.queryRequestListener] = responder

        let storageAdapter = try SQLiteStorageEngineAdapter(connection: Connection(.inMemory))
        try storageAdapter.setUp(models: StorageEngine.systemModels + [MockSynced.self])

        let syncCallbackReceived = expectation(description: "Sync callback received, sync operation is complete")
        let reconciliationQueue = MockReconciliationQueue()
        let operation = InitialSyncOperation(
            modelType: MockSynced.self,
            api: apiPlugin,
            reconciliationQueue: reconciliationQueue,
            storageAdapter: storageAdapter) { _ in
                syncCallbackReceived.fulfill()
        }

        operation.main()

        wait(for: [syncCallbackReceived], timeout: 1.0)

        guard let syncMetadata = try storageAdapter.queryModelSyncMetadata(for: MockSynced.self) else {
            XCTFail("syncMetadata is nil")
            return
        }

        XCTAssertEqual(syncMetadata.lastSync, startDateSeconds)
    }

    /// - Given: An InitialSyncOperation in a system with previous sync metadata
    /// - When:
    ///    - I invoke main()
    /// - Then:
    ///    - It performs a sync query against the API category with a "lastSync" time from the last start time of
    ///      the stored metadata
    func testQueriesFromLastSync() throws {
        let startDateSeconds = Int(Date().timeIntervalSince1970) - 100

        let storageAdapter = try SQLiteStorageEngineAdapter(connection: Connection(.inMemory))
        try storageAdapter.setUp(models: StorageEngine.systemModels + [MockSynced.self])

        let syncMetadata = ModelSyncMetadata(id: MockSynced.modelName, lastSync: startDateSeconds)
        let syncMetadataSaved = expectation(description: "Sync metadata saved")
        storageAdapter.save(syncMetadata) { result in
            switch result {
            case .failure(let dataStoreError):
                XCTAssertNil(dataStoreError)
            case .success:
                syncMetadataSaved.fulfill()
            }
        }
        wait(for: [syncMetadataSaved], timeout: 1.0)

        let apiWasQueried = expectation(description: "API was queried for a PaginatedList of AnyModel")
        let responder = QueryRequestListenerResponder<PaginatedList<AnyModel>> { request, listener in
            let lastSync = request.variables?["lastSync"] as? Int
            XCTAssertEqual(lastSync, startDateSeconds)

            let list = PaginatedList<AnyModel>(items: [], nextToken: nil, startedAt: nil)
            let event: GraphQLOperation<PaginatedList<AnyModel>>.Event = .completed(.success(list))
            listener?(event)
            apiWasQueried.fulfill()
            return nil
        }

        let apiPlugin = MockAPICategoryPlugin()
        apiPlugin.responders[.queryRequestListener] = responder

        let reconciliationQueue = MockReconciliationQueue()
        let operation = InitialSyncOperation(
            modelType: MockSynced.self,
            api: apiPlugin,
            reconciliationQueue: reconciliationQueue,
            storageAdapter: storageAdapter) {_ in }

        operation.main()

        wait(for: [apiWasQueried], timeout: 1.0)
    }
}
