//
// Copyright 2018-2020 Amazon.com,
// Inc. or its affiliates. All Rights Reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Amplify
import Combine
@available(iOS 13.0, *)
extension RemoteSyncEngine {

    /// States are descriptive, they say what is happening in the system right now
    enum State {
        case notStarted

        case pausingSubscriptions
        case pausingMutationQueue
        case initializingSubscriptions(APICategoryGraphQLBehavior, StorageEngineAdapter)
        case performingInitialSync
        case activatingCloudSubscriptions
        case activatingMutationQueue(APICategoryGraphQLBehavior, MutationEventPublisher)
        case notifyingSyncStarted

        case syncEngineActive

        case cleaningUp(AmplifyError?)
        case schedulingRestart(AmplifyError?)

        var displayName: String {
            switch self {
            case .notStarted:
                return "notStarted"
            case .pausingSubscriptions:
                return "pausingSubscriptions"
            case .pausingMutationQueue:
                return "pausingMutationQueue"
            case .initializingSubscriptions:
                return "initializingSubscriptions"
            case .performingInitialSync:
                return "performingInitialSync"
            case .activatingCloudSubscriptions:
                return "activatingCloudSubscriptions"
            case .activatingMutationQueue:
                return "activatingMutationQueue"
            case .notifyingSyncStarted:
                return "notifyingSyncStarted"
            case .syncEngineActive:
                return "syncEngineActive"
            case .cleaningUp:
                return "cleaningUp"
            case .schedulingRestart:
                return "schedulingRestart"
            }
        }
    }
}
