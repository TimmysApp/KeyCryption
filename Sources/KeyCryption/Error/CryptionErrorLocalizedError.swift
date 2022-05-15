//
//  File.swift
//  
//
//  Created by Joe Maghzal on 5/8/22.
//

import Foundation
import UIKit

extension CryptionError: LocalizedError {
    public var errorDescription: String? {
        return description.localized
    }
}

public extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}
