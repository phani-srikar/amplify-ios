//
// Copyright 2018-2020 Amazon.com,
// Inc. or its affiliates. All Rights Reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import XCTest
import AWSMobileClient
@testable import Amplify
import AWSS3StoragePlugin
import AWSS3
import AWSCognitoIdentityProvider
@testable import AmplifyTestCommon

class AWSS3StoragePluginTestBase: XCTestCase {

    static let amplifyConfiguration = "AWSS3StoragePluginTests-amplifyconfiguration"
    static let awsconfiguration = "AWSS3StoragePluginTests-awsconfiguration"
    static let credentials = "AWSS3StoragePluginTests-credentials"

    static let largeDataObject = Data(repeating: 0xff, count: 1_024 * 1_024 * 6) // 6MB

    static var user1: String!
    static var user2: String!
    static var password: String!

    static override func setUp() {
        do {
            let credentials = try TestConfigHelper.retrieveCredentials(forResource: AWSS3StoragePluginTestBase.credentials)

            guard let user1 = credentials["user1"],
                let user2 = credentials["user2"],
                let password = credentials["password"] else {
                XCTFail("Missing credentials.json data")
                return
            }

            AWSS3StoragePluginTestBase.user1 = user1
            AWSS3StoragePluginTestBase.user2 = user2
            AWSS3StoragePluginTestBase.password = password

            let awsConfiguration = try TestConfigHelper.retrieveAWSConfiguration(
                forResource: AWSS3StoragePluginTestBase.awsconfiguration)
            AWSInfo.configureDefaultAWSInfo(awsConfiguration)

        } catch {
            XCTFail("Failed to initialize test set up \(error)")
        }
    }

    override func setUp() {
        do {
            AuthHelper.initializeMobileClient()
            Amplify.reset()

            try Amplify.add(plugin: AWSS3StoragePlugin())
            let amplifyConfig = try TestConfigHelper.retrieveAmplifyConfiguration(
                forResource: AWSS3StoragePluginTestBase.amplifyConfiguration)
            try Amplify.configure(amplifyConfig)
        } catch {
            XCTFail("Failed to initialize and configure Amplify \(error)")
        }
    }

    override func tearDown() {
        Amplify.reset()
        sleep(5)
    }

    // MARK: Common Helper functions

    func uploadData(key: String, dataString: String) {
        uploadData(key: key, data: dataString.data(using: .utf8)!)
    }

    func uploadData(key: String, data: Data) {
        let completeInvoked = expectation(description: "Completed is invoked")

        let operation = Amplify.Storage.uploadData(key: key, data: data, options: nil) { event in
            switch event {
            case .completed:
                completeInvoked.fulfill()
            case .failed(let error):
                XCTFail("Failed with \(error)")
            default:
                break
            }
        }

        XCTAssertNotNil(operation)
        waitForExpectations(timeout: 60)
    }

    static func getBucketFromConfig(forResource: String) throws -> String {
        guard let path = Bundle.main.path(forResource: forResource, ofType: "json") else {
            throw "Could not get \(forResource).json"
        }
        let url = URL(fileURLWithPath: path)
        let data = try Data(contentsOf: url)
        let json = try JSONDecoder().decode(JSONValue.self, from: data)
        guard let bucket = json["storage"]?["plugins"]?["awsS3StoragePlugin"]?["bucket"] else {
            throw "Could not retrieve bucket from config"
        }

        guard case let .string(bucketValue) = bucket else {
            throw "bucket is not a string value"
        }

        return bucketValue
    }
}
