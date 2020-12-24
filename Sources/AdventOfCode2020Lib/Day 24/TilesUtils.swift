//
//  TilesUtils.swift
//  
//
//  Created by Juan on 24/12/20.
//

import Foundation

public struct TilesUtils {
    public init() {}
    public func load(from file: String) -> [[Direction]] {
        let lines = file.trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
        var output = [[Direction]]()

        for var line in lines {
            var lineDirections = [Direction]()
            while line.count > 0 {
                if let direction = Direction(rawValue: String(line.prefix(1))) {
                    lineDirections.append(direction)
                    line.removeFirst()
                } else if let direction = Direction(rawValue: String(line.prefix(2))) {
                    lineDirections.append(direction)
                    line.removeFirst(2)
                } else {
                    print("Invalid input")
                }
            }
            output.append(lineDirections)
        }

        return output
    }

    public func tileLocationAfter(directions: [Direction]) -> TileLocation {
        var location = TileLocation(x: 0, y: 0, z: 0)
        for direction in directions {
            location += direction.tileDirection
        }
        return location
    }

    public func stepTiles(tiles: Set<TileLocation>) -> Set<TileLocation> {
        var newState = Set<TileLocation>()

        var tilesToCheck = Set<TileLocation>()
        for tile in tiles {
            tilesToCheck.insert(tile)
            for direction in Direction.allCases {
                tilesToCheck.insert(tile + direction.tileDirection)
            }
        }

        for tile in tilesToCheck {
            let adjacentTiles = Direction.allCases.map { tile + $0.tileDirection }
            if tiles.contains(tile) && (tiles.intersection(adjacentTiles).count == 1 || tiles.intersection(adjacentTiles).count == 2) {
                newState.insert(tile)
            } else if !tiles.contains(tile) && tiles.intersection(adjacentTiles).count == 2 {
                newState.insert(tile)
            }
        }

        return newState
    }
}
