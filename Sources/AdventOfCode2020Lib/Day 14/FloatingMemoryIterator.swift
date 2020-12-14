//
//  FloatingMemoryIterator.swift
//  
//
//  Created by Juan on 14/12/20.
//

import Foundation

struct FloatingMemoryIterator: IteratorProtocol {
    let mask: Mask
    let address: UInt64
    let max: UInt64
    var count: UInt64 = 0

    init(mask: Mask, address: UInt64) {
        self.mask = mask
        self.address = address

        max = UInt64(pow(2.0, Double(mask.rawMask.reduce(0, { $0 + ($1 == "X" ? 1 : 0) }))))
    }

    mutating func next() -> UInt64? {
        guard count < max else { return nil }
        var newMask = ""
        var consumedCount = count
        for character in mask.rawMask {
            if character == "0" {
                newMask += "X"
            } else if character == "1" {
                newMask += String(character)
            } else if character == "X" {
                if consumedCount & 1 == 0 {
                    newMask += "0"
                } else {
                    newMask += "1"
                }
                consumedCount = consumedCount >> 1
            }
        }
        count += 1
        let mask = Mask(from: newMask)
        return mask.apply(to: address)
    }
}
