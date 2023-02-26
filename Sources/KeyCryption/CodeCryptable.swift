//
//  File.swift
//  
//
//  Created by Joe Maghzal on 26/02/2023.
//

import Foundation
import KeyValueCoding

public protocol CodeCryptable: Codable, KeyValueCoding, CryptableIterable {
    static var keys: [String: String] {get}
    static var key: String? {get}
}

public extension CodeCryptable {
    static var keys: [String: String] {
        return [:]
    }
    static var key: String? {
        return nil
    }
}

extension CodeCryptable {
    func decoding() -> Self {
        var object = self
        self.allProperties()?.forEach { item in
            guard var keyable = object[item.key] as? Keyable else {return}
            if let cryptingKey = Self.keys[item.key] ?? Self.key {
                keyable.key = cryptingKey
                try? keyable.encrypt()
                object[item.key] = keyable
            }else {
                fatalError("You need to provide either a general key or keys for each property")
            }
        }
        return object
    }
}

public final class CryptableDecoder: JSONDecoder {
    public override func decode<T>(_ type: T.Type, from data: Data) throws -> T where T: Decodable {
        let oldObject = try JSONDecoder().decode(T.self, from: data)
        guard let codeCryptable = oldObject as? CodeCryptable else {
            fatalError()
        }
        return codeCryptable.decoding() as! T
    }
}
