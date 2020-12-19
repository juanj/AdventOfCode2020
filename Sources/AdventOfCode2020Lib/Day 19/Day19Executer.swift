//
//  Day19Executer.swift
//  
//
//  Created by Juan on 19/12/20.
//

import Foundation

public struct Day19Executer: Executer {
    public init() {}
    public func execute(with input: String) {
        let utils = MonsterMessageUtils()
        let (rules, messages) = utils.load(from: input)
        let count = messages.filter { rules["0"]?.match($0) == "" }.count
        print("The number of messages that matches rule 0 is: \(count)")

        let patchedRules = utils.patchRules(rules)
        var patchedRulesCount = 0
        for message in messages {
            if patchedRules["0"]?.match(message) == "" {
                patchedRulesCount += 1
            }
        }
        print("The number of messages that matches rule 0 (with patched rules) is: \(patchedRulesCount)")
    }
}
