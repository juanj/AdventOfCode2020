//
//  OrMessageRule.swift
//  
//
//  Created by Juan on 19/12/20.
//

import Foundation

public class OrMessageRule: MessageRule {
    var subRules: [MessageRule]
    init(rules: [MessageRule]) {
        subRules = rules
    }

    public func match(_ string: String) -> String {
        for rule in subRules {
            let consumedString = rule.match(string)
            if consumedString != string {
                return consumedString
            }
        }
        return string
    }
}
