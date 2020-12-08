//
//  Day8Executer.swift
//  
//
//  Created by Juan on 8/12/20.
//

import Foundation

public struct Day8Executer: Executer {
    public init() {}
    public func execute(with input: String) {
        let parser = InstructionsParser()
        let instructions = parser.parse(file: input)
        let runner = InstructionsRunner()

        print("The value of the accumulator just before loop is: \(runner.runUntilLoop(instructions: instructions))")

        let fixedInstructions = runner.fixInfiniteLoop(instructions: instructions)

        print("The value of the accumulator after running the fixed instrutions is: \(runner.run(instructions: fixedInstructions))")
    }
}
