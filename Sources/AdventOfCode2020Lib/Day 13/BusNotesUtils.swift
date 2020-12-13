//
//  BusNotesUtils.swift
//  
//
//  Created by Juan on 13/12/20.
//

import Foundation

public struct BusNotesUtils {
    public func load(from file: String) -> (Int, [Int]) {
        let input = file.trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: "\n")
        return (Int(input[0]) ?? 0, input[1]
                    .replacingOccurrences(of: "x", with: "0")
                    .components(separatedBy: ",")
                    .compactMap { Int($0) })
    }

    public func closestBus(time: Int, busIds: [Int]) -> (Int, Int) {
        var wait = 0

        while true {
            for id in busIds where id != 0 && (time + wait) % id == 0 {
                return (wait, id)
            }
            wait += 1
        }
    }

    public func findClosest(busIds: [Int]) -> Int {
        // I had a hard time with this one. Thanks to fguchelaar for the algorithm.
        // I commented it to have a better understanding of what its doing

        // List of ids and its offsets
        let numbers = busIds.enumerated().filter { $0.element != 0 }
            .map { (id: $0.element, offset: Int($0.offset)) }

        // Hold last valid time
        var time = 0

        // Increment time by this value so it stays a multiple of the first id
        var interval = numbers[0].id

        // Ignore the first number since offset is 0 and interval is multiplier of it
        for number in numbers.dropFirst() {

            // Start searching for a possible time starting from the last valid time
            var possibleTime = time

            // Keep incrementing time by interval until (by adding the offset) its a multiplier of the id
            while (possibleTime + number.offset) % number.id != 0 {
                possibleTime += interval
            }

            // New last valid time
            time = possibleTime

            // Find the lowest common multiple between the current interval and the id.
            // This will always keep interval as a multiple of the previous ids
            interval = lcm(interval, number.id)
        }

        return time
    }
}
