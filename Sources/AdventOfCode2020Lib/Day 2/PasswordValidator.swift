//
//  PasswordValidator.swift
//  
//
//  Created by Juan on 2/12/20.
//

import Foundation

public class PasswordValidator {
    public init() {}
    public func readPasswordsList(from file: String) -> [(PasswordPolicy, String)] {
        let passwords = file.split(separator: "\n")
            .compactMap { parse(String($0)) }
        return passwords
    }

    public func parse(_ input: String) -> (PasswordPolicy, String) {
        let parts = input.split(separator: " ")
        let positions = parts[0].split(separator: "-").compactMap { Int($0) }

        return (PasswordPolicy(position1: positions[0], position2: positions[1], character: parts[1].first ?? " ") , text: String(parts[2]))
    }

    public func validateOldJob(password: String, with policy: PasswordPolicy) -> Bool {
        let count = password.lowercased()
            .filter { $0 == policy.character }
            .count

        return policy.range.contains(count)
    }

    public func validateToboggan(password: String, with policy: PasswordPolicy) -> Bool {
        let containsPosition1 = password[policy.index1(for: password)] == policy.character
        let containsPosition2 = password[policy.index2(for: password)] == policy.character

        return (containsPosition1 && !containsPosition2) || (!containsPosition1 && containsPosition2)
    }
}
