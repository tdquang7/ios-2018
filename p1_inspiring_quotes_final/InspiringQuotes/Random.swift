//
//  Random.swift
//  InspiringQuotes
//
//  Created by dev on 12/14/16.
//  Copyright © 2016 dev7lab. All rights reserved.
//

import Foundation

class Random {
    @objc static func next(under: Int) -> Int {
        return Int(arc4random_uniform(UInt32(under)))
    }
}

