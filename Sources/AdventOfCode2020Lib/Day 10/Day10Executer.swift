//
//  Day10Executer.swift
//  
//
//  Created by Juan on 10/12/20.
//

import Foundation

public struct Day10Executer: Executer {
    public init() {}
    public func execute(with input: String) {
        let utils = JoltAdapterUtils()
        let adapters = utils.load(from: input)

        let steps = utils.getSteps(adapters: adapters)

        let step1Count = steps.filter { $0 == 1 }.count
        let step2Count = steps.count - step1Count
        print("The number of 1 steps multiplied by the number of 3 steps is \(step1Count * step2Count)")
    }
}
