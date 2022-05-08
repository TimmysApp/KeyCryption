//
//  File.swift
//  
//
//  Created by Joe Maghzal on 5/8/22.
//

import Foundation

enum CryptionError: Error {
    case invalidKeySize(expected: Int, provided: Int)
    case randomIVGeneratorFailed
    case encryptionFailed(reason: String? = nil)
    case decryptionFailed(reason: String? = nil)
    case dataCreationFailed
    case objectCreationFailed
    case emptyKey
}
