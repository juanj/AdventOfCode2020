//
//  Direction.swift
//  
//
//  Created by Juan on 24/12/20.
//

import Foundation

public enum Direction: String, CaseIterable {
    case east = "e"
    case southeast = "se"
    case southwest = "sw"
    case west = "w"
    case northwest = "nw"
    case northeast = "ne"

    var tileDirection: TileLocation {
        switch self {
        case .east:
            return TileLocation(x: 1, y: -1, z: 0)
        case .southeast:
            return TileLocation(x: 0, y: -1, z: 1)
        case .southwest:
            return TileLocation(x: -1, y: 0, z: 1)
        case .west:
            return TileLocation(x: -1, y: 1, z: 0)
        case .northwest:
            return TileLocation(x: 0, y: 1, z: -1)
        case .northeast:
            return TileLocation(x: 1, y: 0, z: -1)
        }
    }
}
