//
//  File.swift
//  
//
//  Created by Joe Maghzal on 5/15/22.
//

import Foundation

public extension Data: Cryptable {
}

public extension String {
    subscript(i: Int) -> String {
        return String(self[index(startIndex, offsetBy: i)])
    }
    func encrypt(using key: String) -> String? {
        return try? KLess(key: key).encrypt(self)
    }
    func decrypt(using key: String) -> String? {
        return try? KLess(key: key).decryptString(self)
    }
    func decrypt(using key: String) -> Int? {
        return try? KLess(key: key).decryptInt(self)
    }
}

public extension Int {
    func encrypt(using key: String) -> String? {
        return try? KLess(key: key).encrypt(int: self)
    }
}
