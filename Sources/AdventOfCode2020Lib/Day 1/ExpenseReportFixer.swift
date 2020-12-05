//
//  ExpenseReportFixer.swift
//  
//
//  Created by Juan on 1/12/20.
//

import Foundation

public class ExpenseReportFixer {
    public init() {}
    public func readExpenseReport(from string: String) -> [Int] {
        let entries = string.split(separator: "\n")
            .compactMap { Int($0) }
        return entries
    }

    public func analyze(entries: [Int], target: Int = 2020, adding: Int = 2) -> Int {
        guard entries.count >= adding else { return 0 }
        let entries = entries.sorted()
        guard let first = entries.first, first < target else { return 0 }

        if adding == 2 {
            var lastIndex = entries.count - 1
            var firstIndex = 0

            while lastIndex != firstIndex {
                let firstElement = entries[firstIndex]
                let lastElement = entries[lastIndex]
                let sum = lastElement + firstElement
                if sum == target {
                    return firstElement * lastElement
                } else if sum < target {
                    firstIndex += 1
                } else if sum > target {
                    lastIndex -= 1
                }
            }
        } else {
            var lastIndex = entries.count - 1
            while lastIndex >= adding - 1 {
                let lastElement = entries[lastIndex]
                let subProduct = analyze(entries: entries.dropLast(entries.count - lastIndex), target: target - lastElement, adding: adding - 1)
                if subProduct != 0 {
                    return subProduct * lastElement
                }
                lastIndex -= 1
            }
        }

        return 0
    }
}
