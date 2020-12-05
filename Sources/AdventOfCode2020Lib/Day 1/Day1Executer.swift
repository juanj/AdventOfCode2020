//
//  File.swift
//  
//
//  Created by Juan on 5/12/20.
//

import Foundation

public struct Day1Executer: Executer {
    public init() {}

    public func execute(with file: String) {
        let fixer = ExpenseReportFixer()
        let entries = fixer.readExpenseReport(from: file)
        print("The product of the 2 entires that sum 2020 is: \(fixer.analyze(entries: entries))")
        print("The product of the 3 entires that sum 2020 is: \(fixer.analyze(entries: entries, adding: 3))")
    }
}
