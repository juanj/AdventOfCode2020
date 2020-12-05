//
//  BoardingPass.swift
//  
//
//  Created by Juan on 5/12/20.
//

import Foundation

public struct BoardingPass {
    let row: Int
    let column: Int

    public init(from string: String) {
        let binary = string.replacingOccurrences(of: "F", with: "0")
            .replacingOccurrences(of: "B", with: "1")
            .replacingOccurrences(of: "R", with: "1")
            .replacingOccurrences(of: "L", with: "0")

        row = Int(binary.dropLast(3), radix: 2) ?? 0
        column = Int(binary.suffix(3), radix: 2) ?? 0
    }

    public var id: Int {
        row * 8 + column
    }
}
