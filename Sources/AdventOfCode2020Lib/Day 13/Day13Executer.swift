//
//  Day13Executer.swift
//  
//
//  Created by Juan on 13/12/20.
//

import Foundation

public struct Day13Executer: Executer {
    public init() {}
    public func execute(with input: String) {
        let utils = BusNotesUtils()
        let (time, busIds) = utils.load(from: input)
        let result = utils.closestBus(time: time, busIds: busIds)
        print("The time you need to wait multiplied by the closest bus id is \(result.0 * result.1)")
        print("The earliest timestamp such that all of the listed bus IDs depart at offsets matching their positions in the list is: \(utils.findClosest(busIds: busIds))")
    }
}
