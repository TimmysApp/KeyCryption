//
//  File.swift
//  
//
//  Created by Joe Maghzal on 26/02/2023.
//

import Foundation

@propertyWrapper
public final class Cryptable<Value: Codable & Equatable & Hashable>: Keyable {
//MARK: - Properties
    internal var key: String
    private let inMemory: Bool
    private var decryptedValue: Value?
    public var data: Data?
//MARK: - Initializer
    public init(wrappedValue defaultValue: Value? = nil, key: CustomStringConvertible, inMemory: Bool = false) {
        self.key = key.description
        self.inMemory = inMemory
        if let defaultValue {
            if inMemory || key.description.isEmpty {
                self.decryptedValue = defaultValue
            }
            if !key.description.isEmpty {
                wrappedValue = defaultValue
            }
        }
    }
//MARK: - Mappings
    public var wrappedValue: Value {
        get {
            if let decryptedValue {
                return decryptedValue
            }
            guard let data else {
                fatalError("No data available")
            }
            do {
                let object = try AES(key: key).decrypt(data, using: Value.self)
                if inMemory {
                    decryptedValue = object
                }
                return object
            }catch {
                fatalError(String(describing: error))
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
    public func encrypt() throws {
        self.data = try AES(key: key).encrypt(object: decryptedValue)
        self.decryptedValue = nil
    }
    public func decrypt() {
        guard let data else {return}
        do {
            self.decryptedValue = try AES(key: key).decrypt(data, using: Value.self)
        }catch {
            fatalError(error.localizedDescription)
        }
    }
}

//MARK: - Codable
extension Cryptable: Codable {
    public convenience init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.init(wrappedValue: try container.decode(Value.self), key: "")
    }
    public func encode(to encoder: Encoder) throws {
        decrypt()
        var container = encoder.singleValueContainer()
        try container.encode(decryptedValue)
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

protocol Keyable {
    var key: String {get set}
    func encrypt() throws
}
