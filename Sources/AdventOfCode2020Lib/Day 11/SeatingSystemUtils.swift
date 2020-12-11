//
//  SeatingSystemUtils.swift
//  
//
//  Created by Juan on 11/12/20.
//

import Foundation

public struct SeatingSystemUtils {
    public func load(from file: String) -> [[SeatState]] {
        file.trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: "\n")
            .map { Array($0).map { SeatState(rawValue: $0) ?? .empty } }
    }

    public func inSightOccupied(seats: [[SeatState]], row: Int, column: Int, onlyAdjacent: Bool = false) -> Int {
        let directions = [[1, 0], [1, 1], [0, 1], [-1, 1], [-1, 0], [-1, -1], [0, -1], [1, -1]]
        var number = 0

        for direction in directions {
            var newRow = row + direction[0]
            var newColumn = column + direction[1]
            lookupLoop: while newRow >= 0 && newRow < seats.count && newColumn >= 0 && newColumn < seats[newRow].count {
                switch seats[newRow][newColumn] {
                case .occupied:
                    number += 1
                    break lookupLoop
                case .empty:
                    break lookupLoop
                case .floor:
                    break
                }

                if onlyAdjacent {
                    break
                }
                newRow += direction[0]
                newColumn += direction[1]
            }
        }

        return number
    }

    public func step(seats: [[SeatState]], tolerance: Int = 4, onlyAdjacent: Bool = true) -> [[SeatState]] {
        var newState = Array(repeating: Array(repeating: SeatState.floor, count: seats[0].count), count: seats.count)

        for row in 0..<seats.count {
            for column in 0..<seats[row].count {
                if seats[row][column] == .empty && inSightOccupied(seats: seats, row: row, column: column, onlyAdjacent: onlyAdjacent) == 0 {
                    newState[row][column] = .occupied
                } else if seats[row][column] == .occupied && inSightOccupied(seats: seats, row: row, column: column, onlyAdjacent: onlyAdjacent) >= tolerance {
                    newState[row][column] = .empty
                } else {
                    newState[row][column] = seats[row][column]
                }
            }
        }

        return newState
    }
}
