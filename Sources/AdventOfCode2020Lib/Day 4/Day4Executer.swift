//
//  Day4Executer.swift
//  
//
//  Created by Juan on 5/12/20.
//

import Foundation

public struct Day4Executer: Executer {
    public init() {}
    public func execute(with input: String) {
        let loader = CredentialLoader()
        let credentials = loader.loadBatch(from: input)
        print(credentials.map { $0.isValid() }.filter { $0 }.count)
    }
}
