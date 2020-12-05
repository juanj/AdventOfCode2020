//
//  Day2Executer.swift
//  
//
//  Created by Juan on 5/12/20.
//

import Foundation

public struct Day2Executer: Executer {
    public init() {}
    public func execute(with input: String) {
        let validator = PasswordValidator()
        let passwords = validator.readPasswordsList(from: input)
        print(#"Passwords valid with "old job at the sled rental place" policy: \#(passwords.filter { validator.validateOldJob(password: $0.1, with: $0.0) }.count)"#)
        print(#"Passwords valid with "Official Toboggan Corporate" policy: \#(passwords.filter { validator.validateToboggan(password: $0.1, with: $0.0) }.count)"#)
    }
}
