//
//  Day5Executer.swift
//  
//
//  Created by Juan on 5/12/20.
//

import Foundation

public struct Day5Executer: Executer {
    public init() {}
    public func execute(with input: String) {
        let utils = BoardingPassUtils()
        let boardingPasses = utils.loadList(from: input)
        print("Max id: \(utils.max(boardingPasses: boardingPasses))")
        print("Missing id: \(utils.findMissing(boardingPasses: boardingPasses))")
    }
}
