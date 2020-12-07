//
//  Day7Executer.swift
//  
//
//  Created by Juan on 7/12/20.
//

import Foundation

public struct Day7Executer: Executer {
    public init() {}
    public func execute(with input: String) {
        let utils = BagRulesUtils()
        let rules = utils.parse(file: input)

        let contained = rules.map { $0.key }
            .map { utils.isInside(rules: rules, containerColor: $0, innerColor: "shinygold") ? 1 : 0 }
            .reduce(0, +)
        print("Number of colors that eventualy contains shiny gold: \(contained)")
    }
}
