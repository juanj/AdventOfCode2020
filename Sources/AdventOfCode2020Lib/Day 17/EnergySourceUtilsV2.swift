//
//  EnergySourceUtils.swift
//  
//
//  Created by Juan on 17/12/20.
//

import Foundation

// First approach didn't generalize well for more dimensions, so start part2 from scratch
public struct EnergySourceUtilsV2 {
    private let neighborsPositions: [CubePosition] = {
        var positions = [CubePosition]()
        for x in [-1, 0, 1] {
            for y in [-1, 0, 1] {
                for z in [-1, 0, 1] {
                    for w in [-1, 0, 1] {
                        if !(x == 0 && y == 0 && z == 0 && w == 0) {
                            positions.append(CubePosition(x: x, y: y, z: z, w: w))
                        }
                    }
                }
            }
        }
        return positions
    }()
    public init() {}

    public func load(from file: String) -> [CubePosition] {
        let start = file.trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
            .map {
                $0.map { $0 == "#" ? 1 : 0 }
            }
        var positions = [CubePosition]()
        for (y, row) in start.enumerated() {
            for (x, value) in row.enumerated() where value == 1 {
                positions.append(CubePosition(x: x, y: y, z: 0, w: 0))
            }
        }

        return positions
    }

    public func neighborsCount(active: [CubePosition], position: CubePosition) -> Int {
        var count = 0

        for neighbor in neighborsPositions {
            let neighborPosition = position + neighbor
            if active.contains(neighborPosition) {
                count += 1
            }
        }

        return count
    }

    public func step(active: [CubePosition]) -> [CubePosition] {
        var newActive = [CubePosition]()
        var checked = [CubePosition]()

        for position in active {
            for neighbor in neighborsPositions {
                let newPosition = position + neighbor
                if checked.contains(newPosition) {
                    continue
                }
                let neighbors = neighborsCount(active: active, position: newPosition)
                if active.contains(newPosition) {
                    if neighbors == 2 || neighbors == 3 {
                        newActive.append(newPosition)
                    }
                } else {
                    if neighbors == 3 {
                        newActive.append(newPosition)
                    }
                }
                checked.append(newPosition)
            }
        }

        return newActive
    }
}
