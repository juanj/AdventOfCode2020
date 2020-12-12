//
//  NavigationUtils.swift
//  
//
//  Created by Juan on 12/12/20.
//

import Foundation

public struct NavigationUtils {
    public init() {}
    func loadInstructions(from file: String) -> [NavigationInstruction] {
        file.trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: "\n")
            .map {
                let action = NavigationInstruction.Action(rawValue: String($0.first ?? "N")) ?? .north
                let value = Int($0.dropFirst()) ?? 0
                return NavigationInstruction(action: action, value: value)
            }
    }

    func executeNavigation(instructions: [NavigationInstruction]) -> Position {
        var position = Position(northSouth: 0, eastWest: 0, angle: 0)

        for instruction in instructions {
            position = instruction.execute(position)
        }

        return position
    }

    func executeWaypointNavigation(instructions: [NavigationInstruction], initialWayPont: Position) -> Position {
        var shipPosition = Position(northSouth: 0, eastWest: 0, angle: 0)
        var waypoint = initialWayPont
        for instruction in instructions {
            if instruction.action != .forward {
                waypoint = instruction.updateWaypoint(waypoint)
            } else {
                shipPosition.eastWest += waypoint.eastWest * instruction.value
                shipPosition.northSouth += waypoint.northSouth * instruction.value
            }
        }

        return shipPosition
    }
}
