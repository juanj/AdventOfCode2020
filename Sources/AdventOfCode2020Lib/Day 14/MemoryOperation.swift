//
//  File.swift
//  
//
//  Created by Juan on 14/12/20.
//

import Foundation

public struct MemoryOperation: Equatable {
    let mask: Mask
    var assignments: [Int: UInt64]

    public func execute(on memory: [Int: UInt64]) -> [Int: UInt64] {
        var memory = memory
        for assignment in assignments {
            memory[assignment.key] = mask.apply(to: assignment.value)
        }
        return memory
    }
}
