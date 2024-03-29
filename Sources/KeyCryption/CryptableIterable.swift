//
//  File.swift
//  
//
//  Created by Joe Maghzal on 26/02/2023.
//

import Foundation

public protocol CryptableIterable {
    var properties: [String: Any]? {get}
}

public extension CryptableIterable {
    var properties: [String: Any]? {
        var result: [String: Any] = [:]
        let mirror = Mirror(reflecting: self)
        guard let style = mirror.displayStyle, style == .struct || style == .class else {
            return nil
        }
        for (property, value) in mirror.children {
            guard let property = property else {
                continue
            }
            result[property] = value
        }
        return result
    }
}
