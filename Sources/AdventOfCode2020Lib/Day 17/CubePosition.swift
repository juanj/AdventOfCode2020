//
//  Position.swift
//  
//
//  Created by Juan on 17/12/20.
//

import Foundation

public struct CubePosition: Equatable, Hashable {
    let x: Int
    let y: Int
    let z: Int
    let w: Int
}

extension CubePosition {
    static func +(lhs: CubePosition, rhs: CubePosition) -> CubePosition {
        return CubePosition(x: lhs.x + rhs.x, y: lhs.y + rhs.y, z: lhs.z + rhs.z, w: lhs.w + rhs.w)
    }
}
