//
//  File.swift
//  
//
//  Created by Juan on 2/12/20.
//

import Foundation

public struct PasswordPolicy: Equatable {
    let position1: Int
    let position2: Int
    let character: Character

    var range: ClosedRange<Int> {
        return position1...position2
    }

    func index1(for string: String) -> String.Index {
        return string.index(string.startIndex, offsetBy: position1 - 1)
    }

    func index2(for string: String) -> String.Index {
        return string.index(string.startIndex, offsetBy: position2 - 1)
    }
}
