//
//  NavigationInstruction.swift
//  
//
//  Created by Juan on 12/12/20.
//

import Foundation

public struct NavigationInstruction {
    enum Action: String {
        case north = "N"
        case south = "S"
        case east = "E"
        case west = "W"
        case left = "L"
        case right = "R"
        case forward = "F"
    }

    let action: Action
    let value: Int

    private let angleToDirection: [Int: [Int]] = [0: [0, 1], 90: [-1, 0], 180: [0, -1], 270: [1, 0]]

    func execute(_ position: Position) -> Position {
        var position = position
        switch action {
        case .north:
            position.northSouth += value
        case .south:
            position.northSouth -= value
        case .east:
            position.eastWest += value
        case .west:
            position.eastWest -= value
        case .left:
            position.angle = (Int(position.angle - value) + 360) % 360
        case .right:
            position.angle = (Int(position.angle + value) + 360) % 360
        case .forward:
            let direction = angleToDirection[position.angle] ?? [0, 0]
            position.northSouth += direction[0] * value
            position.eastWest += direction[1] * value
        }

        return position
    }

    func updateWaypoint(_ position: Position) -> Position {
        var waypoint = position

        switch action {
        case .north:
            waypoint.northSouth += value
        case .south:
            waypoint.northSouth -= value
        case .east:
            waypoint.eastWest += value
        case .west:
            waypoint.eastWest -= value
        case .left:
            let angleSin = sin(Double(-value) * .pi / 180)
            let angleCos = cos(Double(-value) * .pi / 180)

            waypoint.northSouth = Int(round(Double(position.northSouth) * angleCos - Double(position.eastWest) * angleSin))
            waypoint.eastWest = Int(round(Double(position.northSouth) * angleSin + Double(position.eastWest) * angleCos))
        case .right:
            let angleSin = sin(Double(value) * .pi / 180)
            let angleCos = cos(Double(value) * .pi / 180)

            waypoint.northSouth = Int(round(Double(position.northSouth) * angleCos - Double(position.eastWest) * angleSin))
            waypoint.eastWest = Int(round(Double(position.northSouth) * angleSin + Double(position.eastWest) * angleCos))
        case .forward:
            break
        }

        return waypoint
    }
}
