//
//  CredentialValidator.swift
//  
//
//  Created by Juan on 4/12/20.
//

import Foundation

public struct CredentialLoader {
    public init() {}
    public func loadBatch(from file: String) -> [Credential] {
        var last: Character = " "
        return file.split { character in
            defer {
                last = character
            }
            return last == "\n" && character == "\n"
        }
        .map { Credential(from: String($0)) }
    }
}
