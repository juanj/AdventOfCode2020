//
//  Day14Executer.swift
//  
//
//  Created by Juan on 14/12/20.
//

import Foundation

public struct Day14Executer: Executer {
    public init() {}
    public func execute(with input: String) {
        let utils = MemoryUtils()
        let operations = utils.load(from: input)
        var memory = [String: UInt64]()
        for operation in operations {
            memory = operation.execute(on: memory)
        }
        print("The sum of all values left in memory is \(memory.reduce(0, { $0 + $1.value }))")

        var memoryV2 = [String: UInt64]()
        for operation in operations {
            memoryV2 = operation.executeV2(on: memoryV2)
        }
        print("The sum of all values left in memoryV2 is \(memoryV2.reduce(0, { $0 + $1.value }))")
    }
}
