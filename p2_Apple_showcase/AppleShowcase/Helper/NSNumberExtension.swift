//
//  NSNumberExtension.swift
//  AppleShowcase
//
//  Created by dev7 on 1/6/17.
//  Copyright © 2017 dev7. All rights reserved.
//

import Foundation

extension NSNumber {
    func toVnd() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 0
        formatter.locale = Locale(identifier: "vi-VN")
        
        return formatter.string(from: self)!
    }
}

extension Int {
    func toVnd() -> String {
        return NSNumber(value: self).toVnd()
    }
}
