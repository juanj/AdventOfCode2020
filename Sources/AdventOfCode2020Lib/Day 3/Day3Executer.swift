//
//  Day3Executer.swift
//  
//
//  Created by Juan on 5/12/20.
//

import Foundation

public struct Day3Executer: Executer {
    public init() {}
    public func execute(with input: String) {
        let navigator = Navigator()
        let map = navigator.loadMap(from: input)
        let slopes = [[1, 1], [3, 1], [5, 1], [7, 1], [1, 2]]
        var result = 1
        for slope in slopes {
            let trees = navigator.treesInPath(map: map, stepsRight: slope[0], stepsDown: slope[1])
            print("Trees with slope \(slope[0]) right, \(slope[1]) down: \(trees)")
            result *= trees
        }
        print("Product of the number of trees encountered on each of the slopes: \(result)")
    }
}
