//
//  File.swift
//  
//
//  Created by Joe Maghzal on 5/8/22.
//

import Foundation
import CommonCrypto

internal extension AES {
    func encrypt(_ dataToEncrypt: Data) throws -> Data {
        let bufferSize: Int = ivSize + dataToEncrypt.count + kCCKeySizeAES256
        var buffer = Data(count: bufferSize)
        try generateRandomIV(for: &buffer)
        var numberBytesEncrypted: Int = 0
        do {
            try keyData.withUnsafeBytes { keyBytes in
                try dataToEncrypt.withUnsafeBytes { dataToEncryptBytes in
                    try buffer.withUnsafeMutableBytes { bufferBytes in
                        guard let keyBytesBaseAddress = keyBytes.baseAddress,
                            let dataToEncryptBytesBaseAddress = dataToEncryptBytes.baseAddress,
                            let bufferBytesBaseAddress = bufferBytes.baseAddress else {
                            throw CryptionError.encryptionFailed()
                        }
                        let cryptStatus: CCCryptorStatus = CCCrypt(CCOperation(kCCEncrypt), CCAlgorithm(kCCAlgorithmAES), options, keyBytesBaseAddress, keyData.count, bufferBytesBaseAddress, dataToEncryptBytesBaseAddress, dataToEncryptBytes.count, bufferBytesBaseAddress + ivSize, bufferSize, &numberBytesEncrypted)
                        guard cryptStatus == CCCryptorStatus(kCCSuccess) else {
                            throw CryptionError.encryptionFailed()
                        }
                    }
                }
            }
        }catch {
            throw CryptionError.encryptionFailed(reason: String(describing: error))
        }
        let encryptedData: Data = buffer[..<(numberBytesEncrypted + ivSize)]
        return encryptedData
    }
    func decrypt(_ data: Data) throws -> Data {
        let bufferSize: Int = data.count - ivSize
        var buffer = Data(count: bufferSize)
        var numberBytesDecrypted: Int = 0
        do {
            try keyData.withUnsafeBytes { keyBytes in
                try data.withUnsafeBytes { dataToDecryptBytes in
                    try buffer.withUnsafeMutableBytes { bufferBytes in
                        guard let keyBytesBaseAddress = keyBytes.baseAddress,
                            let dataToDecryptBytesBaseAddress = dataToDecryptBytes.baseAddress,
                            let bufferBytesBaseAddress = bufferBytes.baseAddress else {
                            throw CryptionError.decryptionFailed()
                        }
                        let cryptStatus: CCCryptorStatus = CCCrypt(CCOperation(kCCDecrypt), CCAlgorithm(kCCAlgorithmAES128), options, keyBytesBaseAddress, keyData.count, dataToDecryptBytesBaseAddress, dataToDecryptBytesBaseAddress + ivSize, bufferSize, bufferBytesBaseAddress, bufferSize, &numberBytesDecrypted
                        )
                        guard cryptStatus == CCCryptorStatus(kCCSuccess) else {
                            throw CryptionError.decryptionFailed()
                        }
                    }
                }
            }
        }catch {
            throw CryptionError.decryptionFailed(reason: String(describing: error))
        }
        let decryptedData: Data = buffer[..<numberBytesDecrypted]
        return decryptedData
    }
    func decrypt<Object: Codable>(_ data: Data, using model: Object.Type) throws -> Object {
        let data = try decrypt(data)
        return try JSONDecoder().decode(Object.self, from: data)
    }
    func encrypt<Object: Codable>(object: Object) throws -> Data {
        let data = try JSONEncoder().encode(object)
        return try encrypt(data)
    }
}
