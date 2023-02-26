//
//  File.swift
//  
//
//  Created by Joe Maghzal on 26/02/2023.
//

import Foundation

@propertyWrapper
public class Cryptable<Value: Codable> {
    private let key: String
    private let inMemory: Bool
    private var decryptedValue: Value?
    public var data = Data()
    public init(wrappedValue defaultValue: Value? = nil, key: CustomStringConvertible, inMemory: Bool = false) {
        self.key = key.description
        self.inMemory = inMemory
        self.decryptedValue = defaultValue
    }
    public var wrappedValue: Value {
        get {
            if let decryptedValue {
                return decryptedValue
            }
            do {
                let object = try AES(key: key).decrypt(data, using: Value.self)
                if inMemory {
                    decryptedValue = object
                }
                return object
            }catch {
                fatalError(error.localizedDescription)
            }
        }
        set {
            if inMemory {
                decryptedValue = newValue
            }
            do {
                data = try AES(key: key).encrypt(object: newValue)
            }catch {
                fatalError(error.localizedDescription)
            }
        }
    }
    public var projectedValue: Cryptable<Value> {
        return self
    }
    public func decrypt() {
        do {
            self.decryptedValue = try AES(key: key).decrypt(data, using: Value.self)
        }catch {
            fatalError(error.localizedDescription)
        }
    }
    public func removeFromMemory() {
        self.decryptedValue = nil
    }
}
