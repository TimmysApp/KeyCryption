//
//  File.swift
//  
//
//  Created by Joe Maghzal on 26/02/2023.
//

import Foundation

@propertyWrapper
public class Cryptable<Value: Codable & Equatable & Hashable>: Codable {
//MARK: - Properties
    private let key: String
    private let inMemory: Bool
    private var decryptedValue: Value?
    public var data = Data()
//MARK: - Initializer
    public init(wrappedValue defaultValue: Value? = nil, key: CustomStringConvertible, inMemory: Bool = false) {
        self.key = key.description
        self.inMemory = inMemory
        self.decryptedValue = defaultValue
    }
//MARK: - Mappings
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
//MARK: - Functions
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

//MARK: - Hashable
extension Cryptable: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(data)
    }
}

//MARK: - Equatable
extension Cryptable: Equatable {
    public static func == (lhs: Cryptable<Value>, rhs: Cryptable<Value>) -> Bool {
        return lhs.data == rhs.data
    }
}
