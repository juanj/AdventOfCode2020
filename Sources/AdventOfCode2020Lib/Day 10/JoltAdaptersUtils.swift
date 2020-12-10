//
//  File.swift
//  
//
//  Created by Juan on 10/12/20.
//

import Foundation

public struct JoltAdapterUtils {
    public func load(from file: String) -> [Int] {
        file.trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: "\n")
            .compactMap { Int($0) }
    }

    public func getSteps(adapters: [Int]) -> [Int] {
        let adapters = adapters.sorted()

        var steps = [Int]()
        var last = 0
        for adapter in adapters {
            steps.append(adapter - last)
            last = adapter
        }
        steps.append(3)

        return steps
    }

    public func compressSteps(steps: [Int]) -> [(Int, Int)] {
        var compressed = [(Int, Int)]()

        var last = (steps[0], 1)
        for step in steps.dropFirst() {
            if step == last.0 {
                last.1 += 1
            } else {
                compressed.append(last)
                last = (step, 1)
            }
        }
        compressed.append(last)

        return compressed
    }

    public func getNumberOfCombinations(adapters: [Int]) -> Int {
        let compressedSteps = compressSteps(steps: getSteps(adapters: adapters))

        let combinations = compressedSteps.filter { $0.0 == 1 }
            .map(\.1)
            .reduce(1) { result, part -> Int in
                switch part {
                case 1:
                    return result
                case 2:
                    return result * 2
                case 3:
                    return result * 4
                case 4:
                    return result * 7
                default:
                    fatalError("Chains of length \(part) not implemented")
                }
            }

        return combinations
    }
}
