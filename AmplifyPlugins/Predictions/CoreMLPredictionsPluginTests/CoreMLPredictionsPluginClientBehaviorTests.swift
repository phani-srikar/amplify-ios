//
// Copyright 2018-2019 Amazon.com,
// Inc. or its affiliates. All Rights Reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import XCTest
import Amplify
@testable import CoreMLPredictionsPlugin

class CoreMLPredictionsPluginTests: CoreMLPredictionsPluginTestBase {

    func testPluginInterpretText() {
        let operation = coreMLPredictionsPlugin.interpret(text: "Test text")
        XCTAssertNotNil(operation, "Should return a valid operation")
        XCTAssertEqual(queue.size, 1)
    }

    func testPluginConvertTextToSpeech() {
        let operation = coreMLPredictionsPlugin.convert(textToSpeech: "Test text")
        XCTAssertNotNil(operation, "Should return a valid operation")
        XCTAssertEqual(queue.size, 1)
    }

    func testPluginConvertTextToTranslate() {
        let operation = coreMLPredictionsPlugin.convert(textToTranslate: "Test text")
        XCTAssertNotNil(operation, "Should return a valid operation")
        XCTAssertEqual(queue.size, 1)
    }

    func testPluginIdentify() {
        let testBundle = Bundle(for: type(of: self))
        guard let url = testBundle.url(forResource: "people", withExtension: "jpg") else {
            return
        }
        let operation = coreMLPredictionsPlugin.identify(type: .detectCelebrity, image: url)
        XCTAssertNotNil(operation, "Should return a valid operation")
        XCTAssertEqual(queue.size, 1)
    }
}
