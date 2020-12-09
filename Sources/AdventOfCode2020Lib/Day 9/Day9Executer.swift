//
//  Day9Executer.swift
//  
//
//  Created by Juan on 9/12/20.
//

import Foundation

public struct Day9Executer: Executer {
    public init() {}
    public func execute(with input: String) {
        let utils = EncriptedCodeUtils()
        let code = utils.importCode(from: input)

        var invalidNumber = 0
        for index in 0..<code.count {
            if !utils.isValid(code: code, position: index) {
                invalidNumber = code[index]
                print("The first invalid number is \(invalidNumber)")
                break
            }
        }

        let sequence = utils.findSequenceOfNumbers(code: code, sum: invalidNumber)
        print("The smallest and largest numbers of the sequence add up to: \((sequence.min() ?? 0) + (sequence.max() ?? 0))")
    }
}
