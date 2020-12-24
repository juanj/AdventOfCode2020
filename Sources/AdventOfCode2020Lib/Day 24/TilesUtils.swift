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

    public func stepTiles(tiles: [TileLocation: Bool]) -> [TileLocation: Bool] {
        var newState = [TileLocation: Bool]()

        var tilesToCheck = [TileLocation: Bool]()
        for tile in tiles.keys {
            tilesToCheck[tile] = true
            for direction in Direction.allCases {
                tilesToCheck[tile + direction.tileDirection] = true
            }
        }

        for tile in tilesToCheck.keys {
            let adjacentTiles = Direction.allCases.map { tile + $0.tileDirection }
            if tiles[tile] != nil {
                var count = 0
                for adjacentTile in adjacentTiles {
                    count += tiles[adjacentTile] != nil ? 1 : 0
                }
                if count == 1 || count == 2 {
                    newState[tile] = true
                }
            } else {
                var count = 0
                for adjacentTile in adjacentTiles {
                    count += tiles[adjacentTile] != nil ? 1 : 0
                }
                if count == 2 {
                    newState[tile] = true
                }
            }
        }

        return newState
    }
}
