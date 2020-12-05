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
        print(fixer.analyze(entries: entries))
    }
}
