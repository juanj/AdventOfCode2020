//
//  InstructionsParser.swift
//  
//
//  Created by Juan on 8/12/20.
//

import Foundation

public struct InstructionsParser {
    public init() {}
    public func parse(file: String) -> [Instruction] {
        file.trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: "\n")
            .map { Instruction(from: $0) }
    }
}
