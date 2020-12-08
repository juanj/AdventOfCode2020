//
//  File.swift
//  
//
//  Created by Juan on 8/12/20.
//

import Foundation

public struct InstructionsRunner {
    public init() {}
    public func runUntilLoop(instructions: [Instruction]) -> Int {
        var instructions = instructions
        var accumulator = 0
        var pointer = 0

        while !instructions[pointer].executed {
            instructions[pointer].executed = true
            switch instructions[pointer].type {
            case .nop:
                pointer += 1
            case .acc:
                accumulator += instructions[pointer].value
                pointer += 1
            case .jmp:
                pointer += instructions[pointer].value
            }
        }

        return accumulator
    }
}
