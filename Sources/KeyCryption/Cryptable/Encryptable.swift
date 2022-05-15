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
    func encrypt(using key: String) -> Data?
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
    func encrypt(using key: String = "") -> Data? {
        guard !key.isEmpty || !generalKey.isEmpty, let data = data, let encryptedData = try? AES(key: key).encrypt(data) else {
            return nil
        }
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

//MARK: - Encryptable & Data
public extension Encryptable where Self == Data {
    var data: Data? {
        return self
    }
}
