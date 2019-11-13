//
// Copyright 2018-2019 Amazon.com,
// Inc. or its affiliates. All Rights Reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import AWSTranscribe

class AWSTranscribeAdapter: AWSTranscribeBehavior {

    let awsTranscribe: AWSTranscribe

    init(_ awsTranscribe: AWSTranscribe) {
        self.awsTranscribe = awsTranscribe
    }

    func getTranscribe() -> AWSTranscribe {
        return awsTranscribe
    }

}
