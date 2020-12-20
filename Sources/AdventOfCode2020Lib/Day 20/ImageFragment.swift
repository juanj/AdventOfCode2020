//
//  ImageFragment.swift
//  
//
//  Created by Juan on 20/12/20.
//

import Foundation

public struct ImageFragment: CustomStringConvertible {
    let id: Int
    let data: [[Int]]
    var neigbors: [Int]

    var leftBorder: [Int] {
        data.map { $0[0] }
    }

    var rightBorder: [Int] {
        data.compactMap { $0.last }
    }

    var topBorder: [Int] {
        data[0]
    }

    var bottomBorder: [Int] {
        data.last ?? []
    }

    func hasBorder(_ border: [Int]) -> Bool {
        if topBorder == border || topBorder == border.reversed() ||
            bottomBorder == border || bottomBorder == border.reversed() ||
            rightBorder == border || rightBorder == border.reversed() ||
            leftBorder == border || leftBorder == border.reversed() {
            return true
        }

        return false
    }

    public var description: String {
        data.reduce("", { $0 + "\n" + $1.reduce("", { $0 + ($1 == 1 ? "#" : ".") }) })
    }
}
