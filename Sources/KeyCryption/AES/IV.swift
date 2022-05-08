//
//  File.swift
//  
//
//  Created by Joe Maghzal on 5/8/22.
//

import Foundation
import CommonCrypto

extension AES {
    func generateRandomIV(for data: inout Data) throws {
        try data.withUnsafeMutableBytes { dataBytes in
            guard let dataBytesBaseAddress = dataBytes.baseAddress else {
                throw CryptionError.randomIVGeneratorFailed
            }
            let status: Int32 = SecRandomCopyBytes(kSecRandomDefault, kCCKeySizeAES256, dataBytesBaseAddress)
            guard status == 0 else {
                throw CryptionError.randomIVGeneratorFailed
            }
        }
    }
}
