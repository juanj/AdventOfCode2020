//
//  InverseLookupAndRule.swift
//  
//
//  Created by Juan on 19/12/20.
//

import Foundation

public class InverseLookupAndRule: MessageRule {
    private var rule1: MessageRule
    private var rule2: MessageRule
    init(rule1: MessageRule, rule2: MessageRule) {
        self.rule1 = rule1
        self.rule2 = rule2
    }

    public func match(_ string: String) -> String {
        var subString = ""
        for characte in string.reversed() {
            subString.insert(characte, at: subString.startIndex)
            if subString != string && rule2.match(subString) == "" && rule1.match(String(string.dropLast(subString.count))) == "" {
                return ""
            }
        }
        return string
    }
}
