//
//  File.swift
//  
//
//  Created by Joe Maghzal on 5/15/22.
//

import Foundation

internal extension KLess {
    func encrypt(_ string: String? = nil, int: Int? = nil) throws -> String {
        guard string != nil || int != nil else {
            throw CryptionError.encryptionFailed(reason: "Empty data")
        }
        let string = string == nil ? String(int ?? 0): (string ?? "")
        var output = ""
        var randomKey = Int.random(in: 1...9) + Int.random(in: 0..<string.count + 1)
        let gKeyD = Int(try decryptString(gkey))
        if string.isEmpty {
            throw CryptionError.emptyKey
        }else if gKeyD == nil {
            throw CryptionError.emptyKey
        }else {
            let secondKey = randomKey
            if gkey != "" {
                randomKey = randomKey * gKeyD!
            }
            var encrypted: [Double] = [Double(randomKey)]
            for i in 0..<string.count {
                let j = i+1
                let letter = string[i]
                for d in 0..<letters.count {
                    let e = d + 1
                    if letter == letters[d] {
                        encrypted.append(Double(j*e*secondKey))
                    }else if letter == letters[d].capitalized {
                        encrypted.append(Double(j*e*1000*secondKey))
                    }
                }
            }
            for i in 0..<encrypted.count {
                if encrypted[i] == encrypted.last {
                    output = output + "\(Int(encrypted[i]))".mapToLetters()
                }else {
                    output = output + "\(Int(encrypted[i])) ".mapToLetters()
                }
            }
        }
        return output
    }
    func decryptString(_ string: String) throws -> String {
        var string = ""
        let strings = string.mapToNumbers().components(separatedBy: " ")
        var key = Int(strings[0])
        var gkeyD: Int? = 0
        if gkey != "" {
            gkeyD = Int(try decryptString(gkey))
        }
        if string.isEmpty {
            throw CryptionError.emptyKey
        }else if key == nil || key == 0 {
            throw CryptionError.emptyKey
        }else if gkeyD == nil {
            throw CryptionError.emptyKey
        }else {
            if gkeyD != nil {
                key = key! * gkeyD!
            }
            var array = strings.map({Int($0)!/key!})
            array.removeFirst()
            for i in 0..<array.count {
                let j = i+1
                for d in 0..<numbers.count {
                    let e = d + 1
                    if array[i]/j == e {
                        string = string + letters[d]
                    }else if array[i]/(j*1000) == e {
                        string = string + letters[d].capitalized
                    }
                }
            }
        }
        return string
    }
    func decryptInt(_ string: String) throws -> Int? {
        var string = ""
        let strings = string.mapToNumbers().components(separatedBy: " ")
        var key = Int(strings[0])
        let gkeyD = Int(try decryptString(gkey))
        if string.isEmpty {
            throw CryptionError.emptyKey
        }else if key == nil {
            throw CryptionError.emptyKey
        }else if gkeyD == nil {
            throw CryptionError.emptyKey
        }else {
            if gkey != "" {
                key = key! * gkeyD!
            }
            var array = string.mapToNumbers().components(separatedBy: " ").map({Int($0)!/key!})
            array.removeFirst()
            for i in 0..<array.count {
                let j = i+1
                for d in 0..<numbers.count {
                    let e = d + 1
                    if array[i]/j == e {
                        string = string + letters[d]
                    }else if array[i]/(j*1000) == e {
                        string = string + letters[d].capitalized
                    }
                }
            }
            if Int(string) != nil {
                return Int(string)!
            }else {
                throw CryptionError.emptyKey
            }
        }
    }
}
