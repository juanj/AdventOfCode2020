//
//  MessageRule.swift
//  
//
//  Created by Juan on 19/12/20.
//

import Foundation

public protocol MessageRule {
    func match(_ string: String) -> String
}

public class ConcreteMessageRule: MessageRule {
    private var character: String
    init(_ character: String) {
        self.character = character
    }

    public func match(_ string: String) -> String {
        if string.starts(with: character) {
            return String(string.dropFirst(character.count))
        }
        return string
    }
}

public class AndMessageRule: MessageRule {
    var subRules: [MessageRule]
    init(rules: [MessageRule]) {
        subRules = rules
    }

    public func match(_ string: String) -> String {
        // TODO: match("aab") -> aab
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
