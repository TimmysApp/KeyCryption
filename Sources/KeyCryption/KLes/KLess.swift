//
//  File.swift
//  
//
//  Created by Joe Maghzal on 5/15/22.
//

import Foundation

internal struct KLess {
    let gkey: String
    init(key: String) {
        self.gkey = key
    }
}

internal let letters = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", " ", ",", ".", ";", "?", "!", "@", "$", "&", "#", "%", "(", ")", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "'"]
internal let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50]
internal let letters2 = ["a", "b", "c", "d", "e", "f", "g", "h", "i"]
internal let forZero = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
internal let forSpace = ["#", "$", "[", "]", "}", "{", ";", "'", ":", ".", ",", "<", ">", "&", "^", "*", "%", "@", "!", "+", "=", "-", "_"]
