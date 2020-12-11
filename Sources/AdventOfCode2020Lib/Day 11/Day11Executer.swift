//
//  Day11Executer.swift
//  
//
//  Created by Juan on 11/12/20.
//

import Foundation

public struct Day11Executer: Executer {
    public init() {}
    public func execute(with input: String) {
        let utils = SeatingSystemUtils()
        let seats = utils.load(from: input)

        var oldState = seats
        var newState = utils.step(seats: oldState)
        while oldState != newState {
            oldState = newState
            newState = utils.step(seats: oldState)
        }

        let occupied = newState.reduce(0, { $0 + $1.reduce(0, { $0 + ($1 == .occupied ? 1 : 0) }) })
        print("Number of occupied seats after state has stabilized: \(occupied)")

        oldState = seats
        newState = utils.step(seats: oldState, tolerance: 5, onlyAdjacent: false)
        while oldState != newState {
            oldState = newState
            newState = utils.step(seats: oldState, tolerance: 5, onlyAdjacent: false)
        }

        let fixedCccupied = newState.reduce(0, { $0 + $1.reduce(0, { $0 + ($1 == .occupied ? 1 : 0) }) })
        print("Number of occupied seats after state has stabilized with fixed rules: \(fixedCccupied)")
    }
}
