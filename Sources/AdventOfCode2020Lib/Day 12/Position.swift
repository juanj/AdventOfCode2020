//
//  Position.swift
//  
//
//  Created by Juan on 12/12/20.
//

import Foundation

public struct Position: Equatable {
    var northSouth: Int
    var eastWest: Int
    var angle: Int

    var manhattanDistance: Int {
        return abs(northSouth) + abs(eastWest)
    }
}
