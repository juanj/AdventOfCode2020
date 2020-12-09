//
//  EncriptedCodeUtils.swift
//  
//
//  Created by Juan on 9/12/20.
//

import Foundation

public struct EncriptedCodeUtils {
    func importCode(from file: String) -> [Int] {
        return file
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: "\n")
            .compactMap { Int($0) }
    }

    func isValid(code: [Int], position: Int, preamble: Int = 25) -> Bool {
        guard position > preamble else { return true }
        let preambleNumbers = code[(position - preamble)..<position]
        for number in preambleNumbers where preambleNumbers.contains(code[position] - number) {
            return true
        }
        return false
    }

    func findSequenceOfNumbers(code: [Int], sum: Int) -> [Int] {
        var sequence = [Int]()

        var startPoint = 0
        var currentPoint = 0
        while startPoint + currentPoint < code.count {
            let totalSum = sequence.reduce(0, +)
            if totalSum == sum {
                return sequence
            } else if totalSum < sum {
                sequence.append(code[startPoint + currentPoint])
                currentPoint += 1
            } else if totalSum > sum {
                startPoint += 1
                currentPoint = 0
                sequence = []
            }
        }

        return []
    }
}
