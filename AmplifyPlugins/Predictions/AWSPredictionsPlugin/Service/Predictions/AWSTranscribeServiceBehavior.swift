//
// Copyright 2018-2019 Amazon.com,
// Inc. or its affiliates. All Rights Reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import Amplify
import AWSTranscribe

protocol AWSTranscribeServiceBehavior {

    typealias TranscribeServiceEventHandler = (TranscribeServiceEvent) -> Void
    typealias TranscribeServiceEvent = PredictionsEvent<TranscribeSpeechResult, PredictionsError>

}


public struct TranscribeSpeechResult: ConvertResult {

    /// Transcribed text
    public let text: String

    public init(text: String, targetLanguage: LanguageType) {
        self.text = text
    }
}
