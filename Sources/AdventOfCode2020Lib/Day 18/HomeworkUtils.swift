//
//  HomeworkUtils.swift
//  
//
//  Created by Juan on 18/12/20.
//

import Foundation

public struct HomeworkUtils {
    public func load(from file: String) -> [[HomeworkToken]] {
        file.trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
            .map { tokenize($0) }
    }

    public func tokenize(_ string: String) -> [HomeworkToken] {
        var tokens = [HomeworkToken]()

        for character in string {
            if character == "(" {
                tokens.append(.lparen)
            } else if character == ")" {
                tokens.append(.rparen)
            } else if character == "+" {
                tokens.append(.add)
            } else if character == "*" {
                tokens.append(.mul)
            } else if "0"..."9" ~= character, let number = Int(String(character)) {
                tokens.append(.number(number))
            }
        }

        return tokens
    }

    public func reorder(tokens: [HomeworkToken]) -> [HomeworkToken] {
        // Modified Shunting-yard
        // Only + and * operators and all operators have the same priority
        var outputStack = [HomeworkToken]()
        var operatorsStack = [HomeworkToken]()
        for token in tokens {
            switch token {
            case .number:
                outputStack.append(token)
            case .add, .mul:
                while let topOperator = operatorsStack.last, topOperator != .lparen {
                    if let op = operatorsStack.popLast() {
                        outputStack.append(op)
                    }
                }
                operatorsStack.append(token)
            case .lparen:
                operatorsStack.append(token)
            case .rparen:
                while let topOperator = operatorsStack.last, topOperator != .lparen {
                    if let op = operatorsStack.popLast() {
                        outputStack.append(op)
                    }
                }
                if let topOperator = operatorsStack.last, topOperator == .lparen {
                    operatorsStack.removeLast()
                }
            }
        }
        outputStack.append(contentsOf: operatorsStack.reversed())

        return outputStack
    }

    public func execute(tokens: [HomeworkToken]) -> Int {
        var numberStack = [Int]()

        for token in tokens {
            if case .number(let number) = token {
                numberStack.append(number)
            } else if token == .add {
                let number1 = numberStack.popLast()!
                let number2 = numberStack.popLast()!

                numberStack.append(number1 + number2)
            } else if token == .mul {
                let number1 = numberStack.popLast()!
                let number2 = numberStack.popLast()!

                numberStack.append(number1 * number2)
            }
        }
        return numberStack[0]
    }
}
