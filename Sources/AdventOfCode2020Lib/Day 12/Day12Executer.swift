//
//  Day12Executer.swift
//  
//
//  Created by Juan on 12/12/20.
//

import Foundation

public struct Day12Executer: Executer {
    public init() {}
    public func execute(with input: String) {
        let utils = NavigationUtils()
        let instructions = utils.loadInstructions(from: input)
        let position = utils.executeNavigation(instructions: instructions)
        print("After executing the instructions, the manhattan distance is \(position.manhattanDistance)")

        let positionWithWaypoint = utils.executeWaypointNavigation(instructions: instructions, initialWayPont: Position(northSouth: 1, eastWest: 10, angle: 0))
        print("After executing the instructions (with waypoint), the manhattan distance is \(positionWithWaypoint.manhattanDistance)")
    }
}
