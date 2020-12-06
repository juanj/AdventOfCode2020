//
//  Day6Executer.swift
//  
//
//  Created by Juan on 6/12/20.
//

import Foundation

public struct Day6Executer: Executer {
    public init() {}
    public func execute(with input: String) {
        let utils = CustomsUtils()
        let answers = utils.loadAnswers(from: input)
        print("The sum of the number of answers is: \(utils.uniqueAnswers(groups: answers).reduce(0, { $0 + $1.count }))")
        print("The sum of the number of intersections is: \(utils.commonAnswers(groups: answers).reduce(0, { $0 + $1.count }))")
    }
}
