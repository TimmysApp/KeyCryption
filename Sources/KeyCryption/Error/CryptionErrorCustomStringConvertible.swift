//
//  File.swift
//  
//
//  Created by Joe Maghzal on 5/8/22.
//

import Foundation

extension CryptionError: CustomStringConvertible {
    public var description: String {
        switch self {
            case .invalidKeySize(let expected, let provided):
                return "The size of the Provided Key is invalid, expected value \(expected) but current value is \(provided)"
            case .randomIVGeneratorFailed:
                return "The random IV generator has failed with error: "
            case .encryptionFailed(let reason):
                return "The encryption algorithm has failed\(reason == nil ? "": " with reason: \(reason ?? "")")"
            case .decryptionFailed(let reason):
                return "The decryption algorithm has failed\(reason == nil ? "": " with reason: \(reason ?? "")")"
            case .dataCreationFailed:
                return "Could not encode the object to data"
            case .objectCreationFailed:
                return "Could not decode the data to the specified object"
            case .emptyKey:
                return "The provided key is empty! Either set a general key for the object or provide one to the algorithm"
        }
    }
}
