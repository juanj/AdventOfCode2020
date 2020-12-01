//
//  ExpenseReportFixer.swift
//  
//
//  Created by Juan on 1/12/20.
//

import Foundation

public class ExpenseReportFixer {
    public init() {}
    public func readExpenseReport(from path: String) -> [Int] {
        do {
            let expenseReport = try String(contentsOfFile: path)
            let entries = expenseReport.split(separator: "\n")
                .compactMap { Int($0) }
            return entries
        } catch let error {
            print(error.localizedDescription)
            return []
        }
    }

    public func analyze(entries: [Int], target: Int = 2020) -> Int {
        guard entries.count >= 2 else { return 0 }
        let entries = entries.sorted()

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

        return 0
    }
}
