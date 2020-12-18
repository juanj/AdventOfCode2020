//
//  HomeworkToken.swift
//  
//
//  Created by Juan on 18/12/20.
//

import Foundation

public enum HomeworkToken: Equatable, CustomStringConvertible {
    case lparen
    case rparen
    case number(Int)
    case mul
    case add

    public var description: String {
        switch self {
        case .lparen:
            return "("
        case .rparen:
            return ")"
        case .number(let number):
            return String(number)
        case .mul:
            return "*"
        case .add:
            return "+"
        }
    }
}
