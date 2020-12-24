//
//  Day24Executer.swift
//  
//
//  Created by Juan on 24/12/20.
//

import Foundation

public struct Day24Executer: Executer {
    public init() {}
    public func execute(with input: String) {
        let utils = TilesUtils()
        let tiles = utils.load(from: input)
        var onTiles = Set<TileLocation>()
        for directions in tiles {
            let location = utils.tileLocationAfter(directions: directions)
            if onTiles.contains(location) {
                onTiles.remove(location)
            } else {
                onTiles.insert(location)
            }
        }
        print("The total number of black tiles is \(onTiles.count)")

        for _ in 0..<100 {
            onTiles = utils.stepTiles(tiles: onTiles)
        }
        print("After 100 days the total number of black tiles is \(onTiles.count)")
    }
}
