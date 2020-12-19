//
//  ConcreteMessageRule.swift
//  
//
//  Created by Juan on 19/12/20.
//

import Foundation

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
