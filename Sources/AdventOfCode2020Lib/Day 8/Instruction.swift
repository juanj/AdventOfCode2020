//
//  Instruction.swift
//  
//
//  Created by Juan on 8/12/20.
//

import Foundation

public struct Instruction: Equatable {
    public enum InstructionType: String {
        case acc, jmp, nop
    }

    public let type: InstructionType
    public let value: Int
    public var executed: Bool = false

    public init(from string: String) {
        let components = string.components(separatedBy: " ")
        type = InstructionType(rawValue: components[0]) ?? .nop
        value = Int(components[1]) ?? 0
    }

    public init(type: InstructionType, value: Int, executed: Bool = false) {
        self.type = type
        self.value = value
        self.executed = executed
    }
}
