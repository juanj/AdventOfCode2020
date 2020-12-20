//
//  Day20Executer.swift
//  
//
//  Created by Juan on 20/12/20.
//

import Foundation

public struct Day20Executer: Executer {
    public init() {}
    public func execute(with input: String) {
        let utils = CameraArrayUtils()
        var tiles = utils.load(from: input)
        tiles = utils.findNeighbors(images: tiles)
        print("The product of the ids of the corner tiles is \(tiles.filter { $0.neighbors.count == 2 }.reduce(1, { $0 * $1.id }))")

    }
}
