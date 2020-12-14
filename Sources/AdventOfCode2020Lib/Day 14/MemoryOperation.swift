//
//  File.swift
//  
//
//  Created by Juan on 14/12/20.
//

import Foundation

public struct MemoryOperation {
    let mask: Mask
    var assignments: [(address: UInt64, value: UInt64)]

    public func execute(on memory: [String: UInt64]) -> [String: UInt64] {
        var memory = memory
        for assignment in assignments {
            memory[String(assignment.address)] = mask.apply(to: assignment.value)
        }
        return memory
    }

    public func executeV2(on memory: [String: UInt64]) -> [String: UInt64] {
        var memory = memory
        for assignment in assignments{
            var iterator = FloatingMemoryIterator(mask: mask, address: assignment.address)
            while let address = iterator.next() {
                memory[String(address)] = assignment.value
            }
        }
        return memory
    }
}
