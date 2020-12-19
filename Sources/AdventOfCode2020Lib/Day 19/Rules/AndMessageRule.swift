//
//  AndMessageRule.swift
//  
//
//  Created by Juan on 19/12/20.
//

import Foundation

public class AndMessageRule: MessageRule {
    var subRules: [MessageRule]
    init(rules: [MessageRule]) {
        subRules = rules
    }

    public func match(_ string: String) -> String {
        var consumedString = string
        for rule in subRules {
            let newConsumed = rule.match(consumedString)
            if newConsumed != consumedString {
                consumedString = newConsumed
            } else {
                return string
            }
        }
        return consumedString
    }
}
