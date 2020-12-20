//
//  ImageFragment.swift
//  
//
//  Created by Juan on 20/12/20.
//

import Foundation

public struct ImageFragment: CustomStringConvertible {
    enum NeighborPosition: String, CustomStringConvertible {
        case left, leftReverse, right, rightReverse, top, topReverse, bottom, bottomReverse

        var description: String {
            rawValue
        }
    }

    let id: Int
    var data: [[Int]]
    var neighbors: [ImageFragment]

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

    func isNeighbor(_ image: ImageFragment) -> Bool {
        return adjacentBorder(image.topBorder) != nil ||
            adjacentBorder(image.bottomBorder) != nil ||
            adjacentBorder(image.leftBorder) != nil ||
            adjacentBorder(image.rightBorder) != nil
    }

    func adjacentBorder(_ border: [Int]) -> NeighborPosition? {
        if topBorder == border {
            return .top
        } else if topBorder == border.reversed() {
            return .topReverse
        } else if bottomBorder == border {
            return .bottom
        } else if bottomBorder == border.reversed() {
            return .bottomReverse
        } else if rightBorder == border {
            return .right
        } else if rightBorder == border.reversed() {
            return .rightReverse
        } else if leftBorder == border {
            return .left
        } else if leftBorder == border.reversed() {
            return .leftReverse
        }
        return nil
    }

    func isInNeighbors(id: Int) -> Bool {
        neighbors.contains { $0.id == id }
    }

    func getMachingSide(_ image: ImageFragment) -> (mySide: NeighborPosition, hisSide: NeighborPosition)? {
        guard isInNeighbors(id: image.id) else { return nil }
        let mySide: NeighborPosition
        let hisSide: NeighborPosition

        if let side = image.adjacentBorder(topBorder) {
            hisSide = side
            mySide = .top
        } else if let side = image.adjacentBorder(bottomBorder) {
            hisSide = side
            mySide = .bottom
        } else if let side = image.adjacentBorder(leftBorder) {
            hisSide = side
            mySide = .left
        } else if let side = image.adjacentBorder(rightBorder) {
            hisSide = side
            mySide = .right
        } else {
            hisSide = .top
            mySide = .top
        }

        return (mySide, hisSide)
    }

    mutating func rotateData(times: Int) {
        for _ in 0..<times {
            var newData = Array(repeating: Array(repeating: 0, count: data.count), count: data.count)
            for i in 0..<data.count {
                for j in 0..<data.count {
                    newData[i][j] = data[data.count - j - 1][i]
                }
            }
            data = newData
        }
    }

    public var description: String {
        data.reduce("", { $0 + "\n" + $1.reduce("", { $0 + ($1 == 1 ? "#" : ".") }) })
    }
}
