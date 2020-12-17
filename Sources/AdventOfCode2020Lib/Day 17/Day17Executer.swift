//
//  Day17Executer.swift
//  
//
//  Created by Juan on 17/12/20.
//

import Foundation

public struct Day17Executer: Executer {
    public init() {}
    public func execute(with input: String) {
        let utils = EnergySourceUtils()
        let firstLayer = utils.load(from: input)

        var newState = utils.step(state: [firstLayer])
        for _ in 0..<5 {
            newState = utils.step(state: newState)
        }
        print("After 6 iterations the number of on cubes is \(newState.reduce(0, { $0 + $1.reduce(0, { $0 + $1.reduce(0, +)}) }))")

        let utilsV2 = EnergySourceUtilsV2()
        var active = utilsV2.load(from: input)

        for _ in 0..<6 {
            active = utilsV2.step(active: active)
        }
        print("After 6 interations on 4D the number of on cubes is \(active.count)")
    }
}
