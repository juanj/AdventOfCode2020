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
}
