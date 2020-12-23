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
        let numbers = utils.load(from: input)
        var (cup, lookups) = utils.buildLinkedList(numbers: numbers)

        for _ in 0..<100 {
            cup = utils.move(cup: cup, lookups: &lookups)!
        }

        var startCup = cup
        while startCup.label != 1 {
            startCup = startCup.next!
        }
        print("The labesl of the cups after 100 turns are: \(utils.cupsString(cup: startCup).dropFirst())")

        let allNumbers = utils.buildCups(startingCups: numbers)
        var (allCups, allLookups) = utils.buildLinkedList(numbers: allNumbers)

        for _ in 0..<10_000_000 {
            allCups = utils.move(cup: allCups, lookups: &allLookups, max: 1_000_000)!
        }
        print("The product of the two values after 1 is: \(allLookups[1]!.next!.label * allLookups[1]!.next!.next!.label)")
    }
}
