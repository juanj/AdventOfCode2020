//
//  TileLocation.swift
//  
//
//  Created by Juan on 24/12/20.
//

import Foundation

public struct TileLocation: Hashable {
    var x: Int
    var y: Int
    var z: Int

    static func +(lhs: TileLocation, rhs: TileLocation) -> TileLocation {
        TileLocation(x: lhs.x + rhs.x, y: lhs.y + rhs.y, z: lhs.z + rhs.z)
    }

    static func +=(lhs: inout TileLocation, rhs: TileLocation) {
        lhs.x += rhs.x
        lhs.y += rhs.y
        lhs.z += rhs.z
    }
}
