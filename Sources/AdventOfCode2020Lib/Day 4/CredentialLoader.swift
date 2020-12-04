//
//  CredentialValidator.swift
//  
//
//  Created by Juan on 4/12/20.
//

import Foundation

public struct CredentialLoader {
    public init() {}
    public func loadBatch(from path: String) -> [Credential] {
        do {
            let batchFile = try String(contentsOfFile: path)
            var last: Character = " "
            return batchFile.split { character in
                defer {
                    last = character
                }
                return last == "\n" && character == "\n"
            }
            .map { Credential(from: String($0)) }
        } catch let error {
            print(error.localizedDescription)
            return []
        }
    }
}
