//
//  File.swift
//  
//
//  Created by Joe Maghzal on 5/8/22.
//

import Foundation
import CommonCrypto

internal struct AES {
    let keyData: Data
    let ivSize = kCCKeySizeAES256
    let options = CCOptions(kCCOptionPKCS7Padding)
    init(key: String) throws {
        guard key.count == kCCKeySizeAES256 else {
            throw CryptionError.invalidKeySize(expected: kCCKeySizeAES256, provided: key.count)
        }
        self.keyData = Data(key.utf8)
    }
}
