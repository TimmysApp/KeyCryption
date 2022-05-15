//
//  File.swift
//  
//
//  Created by Joe Maghzal on 5/8/22.
//

import Foundation

public protocol Decryptable {
    static func object(from: Data) -> Self?
    static func decrypt(using key: String, data: Data) throws -> Self
}

//MARK: - Decryptable & AES
public extension Decryptable {
    static func decrypt(using key: String, data: Data) throws -> Self {
        let decryptedData = try AES(key: key).decrypt(data)
        guard let object = object(from: decryptedData) else {
            throw CryptionError.objectCreationFailed
        }
        return object
    }
}

//MARK: - Decryptable & Codable
public extension Decryptable where Self: Codable {
    var generalKey: String {
        get {
            return ""
        }
        set {
        }
    }
    static func object(from data: Data) -> Self? {
        let decoder = JSONDecoder()
        let object = try? decoder.decode(Self.self, from: data)
        return object
    }
}
