//
//  File.swift
//  
//
//  Created by Juan on 2/12/20.
//

import Foundation

public struct Password: Equatable {
    let text: String
    let position1: Int
    let position2: Int
    let character: Character

    var range: ClosedRange<Int> {
        return position1...position2
    }

    var index1: String.Index {
        return text.index(text.startIndex, offsetBy: position1 - 1)
    }

    var index2: String.Index {
        return text.index(text.startIndex, offsetBy: position2 - 1)
    }
}
