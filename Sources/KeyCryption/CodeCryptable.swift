//
//  File.swift
//  
//
//  Created by Joe Maghzal on 26/02/2023.
//

import Foundation
import KeyValueCoding

public protocol CodeCryptable: Codable, KeyValueCoding, Iterable {
    static var empty: Self {get}
}

extension CodeCryptable {
    func decoding() -> Self {
        var oldObject = self
        var newObject = Self.empty
        self.allProperties()?.forEach { item in
            if var object = oldObject[item.key] as? Keyable, let cryptingKey = newObject[item.key] as? Keyable {
                object.key = cryptingKey.key
                try? object.encrypt()
                newObject[item.key] = object
            }else {
                newObject[item.key] = oldObject[item.key]
            }
        }
        return newObject
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
