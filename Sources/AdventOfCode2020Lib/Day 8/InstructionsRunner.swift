//
//  File.swift
//  
//
//  Created by Juan on 8/12/20.
//

import Foundation

public struct InstructionsRunner {
    public init() {}
    public func run(instructions: [Instruction]) -> Int {
        var instructions = instructions
        var accumulator = 0
        var pointer = 0

        while pointer < instructions.count {
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

    public func isLoop(instructions: [Instruction]) -> Bool {
        var instructions = instructions
        var pointer = 0

        while pointer < instructions.count {
            if instructions[pointer].executed {
                return true
            }

            instructions[pointer].executed = true
            switch instructions[pointer].type {
            case .nop, .acc:
                pointer += 1
            case .jmp:
                pointer += instructions[pointer].value
            }
        }

        return false
    }

    public func fixInfiniteLoop(instructions: [Instruction]) -> [Instruction] {
        guard isLoop(instructions: instructions) else {
            return instructions
        }

        for (index, instruction) in instructions.enumerated() where instruction.type == .nop || instruction.type == .jmp {
            var newInstructions = instructions
            newInstructions[index] = instruction.type == .nop ? Instruction(type: .jmp, value: instruction.value) : Instruction(type: .nop, value: instruction.value)
            if !isLoop(instructions: newInstructions) {
                return newInstructions
            }
        }

        return []
    }
}
