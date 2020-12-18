//
//  Day18Executer.swift
//  
//
//  Created by Juan on 18/12/20.
//

import Foundation

public struct Day18Executer: Executer {
    public init() {}
    public func execute(with input: String) {
        let utils = HomeworkUtils()
        let expressions = utils.load(from: input)
        let result = expressions
            .map { utils.reorder(tokens: $0) }
            .map { utils.execute(tokens: $0) }
            .reduce(0, +)
        print("The result of the sum of the expressions is \(result)")
    }
}
