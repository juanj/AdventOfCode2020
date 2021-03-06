//
//  Navigator.swift
//  
//
//  Created by Juan on 3/12/20.
//

import Foundation

public struct Navigator {
    public init() {}
    public func loadMap(from file: String) -> [[Int]] {
        let map = parseMap(file)
        return map
    }

    public func parseMap(_ map: String) -> [[Int]] {
        map.split(separator: "\n")
            .map { $0.map { $0 == "#" ? 1 : 0 } }
    }

    public func treesInPath(map: [[Int]], stepsRight: Int = 3, stepsDown: Int = 1) -> Int {
        var trees = 0
        var xCoordinate = 0
        for (index, row) in map.enumerated() {
            if index % stepsDown != 0 {
                continue
            }
            if index != 0 {
                trees += row[xCoordinate]
            }
            xCoordinate = (xCoordinate + stepsRight) % row.count
        }
        return trees
    }
}
