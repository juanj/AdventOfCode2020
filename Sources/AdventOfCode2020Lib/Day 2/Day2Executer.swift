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
        let password = validator.readPasswordsList(from: input)
        print(password.filter { validator.validateToboggan($0) }.count)
    }
}
