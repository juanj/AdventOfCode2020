//
//  CupGameUtils.swift
//  
//
//  Created by Juan on 23/12/20.
//

import Foundation

public struct CupGameUtils {
    public init() {}
    public func load(from file: String) -> [Int] {
        file.trimmingCharacters(in: .whitespacesAndNewlines)
            .compactMap { Int(String($0)) }
    }

    public func buildLinkedList(numbers: [Int]) -> (Cup, [Int: Cup]) {
        var lookups = [Int: Cup]()
        let firstCup = Cup(label: numbers[0])
        lookups[numbers[0]] = firstCup
        var previousCup = firstCup
        for number in numbers.dropFirst() {
            let nextCup = Cup(label: number, previous: previousCup)
            lookups[number] = nextCup
            previousCup.next = nextCup
            previousCup = nextCup
        }
        previousCup.next = firstCup
        firstCup.previous = previousCup
        return (firstCup, lookups)
    }

    public func move(cup: Cup, lookups: inout [Int: Cup], max: Int = 9) -> Cup? {
        guard let section = cup.next else { return nil }
        section.previous = nil
        cup.next = section.next?.next?.next
        section.next?.next?.next?.previous = cup
        section.next?.next?.next = nil

        var target = cup.label - 1
        if target <= 0 {
            target = max
        }
        let labels = [section.label, section.next!.label, section.next!.next!.label]
        while labels.contains(target) {
            target -= 1
            if target <= 0 {
                target = max
            }
        }
        let targetCup = lookups[target]
        section.previous = targetCup
        section.next?.next?.next = targetCup?.next
        targetCup?.next = section
        return cup.next
    }

    public func cupsString(cup: Cup) -> String {
        var string = "\(cup.label)"
        var currentCup = cup.next!

        while currentCup.next !== cup {
            string += "\(currentCup.label)"
            currentCup = currentCup.next!
        }
        string += "\(currentCup.label)"

        return string
    }

    public func buildCups(startingCups: [Int]) -> [Int] {
        var cups = startingCups
        while cups.count < 1_000_000 {
            cups.append(cups.count + 1)
        }
        return cups
    }
}
