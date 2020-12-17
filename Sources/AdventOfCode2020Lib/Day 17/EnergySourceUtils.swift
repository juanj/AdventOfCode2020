//
//  EnergySourceUtils.swift
//  
//
//  Created by Juan on 17/12/20.
//

import Foundation

public struct EnergySourceUtils {
    public struct Sides: OptionSet {
        public init(rawValue: Int) {
            self.rawValue = rawValue
        }

        public let rawValue: Int

        static let top = Sides(rawValue: 1 << 0)
        static let bottom = Sides(rawValue: 1 << 1)
        static let front = Sides(rawValue: 1 << 2)
        static let back = Sides(rawValue: 1 << 3)
        static let left = Sides(rawValue: 1 << 4)
        static let right = Sides(rawValue: 1 << 5)
    }

    private var neighbors = [(x: Int, y: Int, z: Int)]()
    public init() {
        for x in [0, 1, -1] {
            for y in [0, 1, -1] {
                for z in [0, 1, -1] {
                    if !(x == 0 && y == 0 && z == 0) {
                        neighbors.append((x, y, z))
                    }
                }
            }
        }
    }

    public func load(from file: String) -> [[Int]] {
        file.trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
            .map {
                $0.compactMap { $0 == "." ? 0: 1 }
            }
    }

    public func neighborsOn(state: [[[Int]]], point: (x: Int, y: Int, z: Int)) -> Int {
        var count = 0
        for neighbor in neighbors {
            let newPoint = (x: point.x + neighbor.x, y: point.y + neighbor.y, z: point.z + neighbor.z)
            if newPoint.z >= 0 && newPoint.z < state.count &&
                newPoint.y >= 0 && newPoint.y < state[newPoint.z].count &&
                newPoint.x >= 0 && newPoint.x < state[newPoint.z][newPoint.y].count {
                count += state[newPoint.z][newPoint.y][newPoint.x]
            }
        }
        return count
    }

    func facesNeeded(state: [[[Int]]]) -> Sides {
        var facesNeeded: Sides = []
        for layer in state {
            for row in layer {
                if row.first == 1 {
                    facesNeeded.update(with: Sides.left)
                }
            }
        }

        for layer in state {
            for row in layer {
                if row.last == 1 {
                    facesNeeded.update(with: Sides.right)
                }
            }
        }

        for layer in state {
            if layer.first?.contains(1) == true {
                facesNeeded.update(with: Sides.back)
            }
        }

        for layer in state {
            if layer.last?.contains(1) == true {
                facesNeeded.update(with: Sides.front)
            }
        }

        for row in state.first ?? [] {
            if row.contains(1) {
                facesNeeded.update(with: .bottom)
            }
        }

        for row in state.last ?? [] {
            if row.contains(1) {
                facesNeeded.update(with: .top)
            }
        }

        return facesNeeded
    }

    public func addFaces(state: [[[Int]]], sides: Sides) -> [[[Int]]] {
        var newState = state
        if sides.contains(.top) {
            newState.append(Array(repeating: Array(repeating: 0, count: newState[0][0].count), count: newState[0].count))
        }
        if sides.contains(.bottom) {
            newState.insert((Array(repeating: Array(repeating: 0, count: newState[0][0].count), count: newState[0].count)), at: 0)
        }
        if sides.contains(.front) {
            for layer in 0..<newState.count {
                newState[layer].append(Array(repeating: 0, count: newState[layer][0].count))
            }
        }
        if sides.contains(.back) {
            for layer in 0..<newState.count {
                newState[layer].insert(Array(repeating: 0, count: newState[layer][0].count), at: 0)
            }
        }
        if sides.contains(.left) {
            for layer in 0..<newState.count {
                for row in 0..<newState[layer].count {
                    newState[layer][row].insert(0, at: 0)
                }
            }
        }
        if sides.contains(.right) {
            for layer in 0..<newState.count {
                for row in 0..<newState[layer].count {
                    newState[layer][row].append(0)
                }
            }
        }
        return newState
    }

    public func step(state: [[[Int]]]) -> [[[Int]]] {
        let sides = facesNeeded(state: state)
        let paddedState = addFaces(state: state, sides: sides)
        var newState = paddedState

        for layer in 0..<newState.count {
            for row in 0..<newState[layer].count {
                for column in 0..<newState[layer][row].count {
                    let neighbors = neighborsOn(state: paddedState, point: (x: column, y: row, z: layer))
                    if newState[layer][row][column] == 1 && neighbors != 2 && neighbors != 3 {
                        newState[layer][row][column] = 0
                    } else if newState[layer][row][column] == 0 && neighbors == 3 {
                        newState[layer][row][column] = 1
                    }
                }
            }
        }

        return newState
    }
}
