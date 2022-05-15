//
//  File.swift
//  
//
//  Created by Joe Maghzal on 5/8/22.
//

import Foundation

public protocol Encryptable {
    var generalKey: String {get set}
    var data: Data? {get}
    func encrypt(using key: String) throws -> Data
}

public extension Encryptable {
    var generalKey: String {
        get {
            return ""
        }
        set {
            generalKey = newValue
        }
    }
}

//MARK: - Encryptable & AES
public extension Encryptable {
    func encrypt(using key: String = "") throws -> Data {
        guard !key.isEmpty && !generalKey.isEmpty else {
            throw CryptionError.emptyKey
        }
        guard let data = data else {
            throw CryptionError.dataCreationFailed
        }
        let encryptedData = try AES(key: key).encrypt(data)
        return encryptedData
    }
}

//MARK: - Encryptable & Codable
public extension Encryptable where Self: Codable {
    var data: Data? {
        let encoder = JSONEncoder()
        return try? encoder.encode(self)
    }
}
