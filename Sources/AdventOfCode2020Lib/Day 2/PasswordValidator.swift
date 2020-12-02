//
//  PasswordValidator.swift
//  
//
//  Created by Juan on 2/12/20.
//

import Foundation

public class PasswordValidator {
    public init() {}
    public func readPasswordsList(from path: String) -> [Password] {
        do {
            let passwordsList = try String(contentsOfFile: path)
            let passwords = passwordsList.split(separator: "\n")
                .compactMap { parse(String($0)) }
            return passwords
        } catch let error {
            print(error.localizedDescription)
            return []
        }
    }

    public func parse(_ input: String) -> Password {
        let parts = input.split(separator: " ")
        let bounds = parts[0].split(separator: "-").compactMap { Int($0) }

        return Password(text: String(parts[2]), range: bounds[0]...bounds[1], character: parts[1].first ?? " ")
    }

    public func validate(_ password: Password) -> Bool {
        let count = password.text.lowercased()
            .filter { $0 == password.character }
            .count

        return password.range.contains(count)
    }
}
