//
//  Day23Executer.swift
//  
//
//  Created by Juan on 23/12/20.
//

import Foundation

public struct Day23Executer: Executer {
    public init() {}
    public func execute(with input: String) {
        let utils = CupGameUtils()
        var cups = utils.load(from: input)

        for _ in 0..<100 {
            cups = utils.move(cups: cups)
        }

        while cups.first != 1 {
            cups += [cups.removeFirst()]
        }
        cups.removeFirst()

        print("The labesl fo the cups after 100 turns are: \(cups.reduce("", { $0 + String($1) }))")
    }
}
