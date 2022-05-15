//
//  File.swift
//  
//
//  Created by Joe Maghzal on 5/15/22.
//

import Foundation

internal extension String {
    func mapToLetters() -> String {
        var toReturn = self
        for d in 0..<letters2.count {
            let e = d + 1
            toReturn = toReturn.replacingOccurrences(of: "\(e)", with: letters2[d])
        }
        let random = Int.random(in: 0..<forSpace.count)
        toReturn = toReturn.replacingOccurrences(of: " ", with: forSpace[random])
        let random2 = Int.random(in: 0..<forZero.count)
        toReturn = toReturn.replacingOccurrences(of: "0", with: forZero[random2])
        return toReturn
    }
    func mapToNumbers() -> String {
        var toReturn = self
        for i in 0..<forSpace.count {
            toReturn = toReturn.replacingOccurrences(of: forSpace[i], with: " ")
        }
        for i in 0..<forZero.count {
            toReturn = toReturn.replacingOccurrences(of: forZero[i], with: "0")
        }
        for d in 0..<letters2.count {
            let e = d + 1
            toReturn = toReturn.replacingOccurrences(of: letters2[d], with: "\(e)")
        }
        return toReturn
    }
}
