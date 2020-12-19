//
//  RecusriveRule.swift
//  
//
//  Created by Juan on 19/12/20.
//

import Foundation

public class RecursivePlaceholder: MessageRule {
    public func match(_ string: String) -> String {
        fatalError("Don't call RecursivePlaceHolder directly")
    }
}

public class RecusriveRule: MessageRule {
    private let baseCase: MessageRule
    private let recursiveCase: [MessageRule]
    init(baseCase: MessageRule, recursiveCase: [MessageRule]) {
        self.baseCase = baseCase
        self.recursiveCase = recursiveCase
    }

    public func match(_ string: String) -> String {
        // Check recursive path
        var consumedString = string
        for rule in recursiveCase {
            let newConsumed: String
            if rule is RecursivePlaceholder {
                // Check recursive path
                newConsumed = match(consumedString)
            } else {
                // If rule is not recursive placeholder, execute normally
                newConsumed = rule.match(consumedString)
            }

            if newConsumed != consumedString {
                consumedString = newConsumed
            } else {
                // Check base case
                let baseMatch = baseCase.match(string)
                if baseMatch != string {
                    return baseMatch
                }
                return string
            }
        }
        return consumedString
    }
}
