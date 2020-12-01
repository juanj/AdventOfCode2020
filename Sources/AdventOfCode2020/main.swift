import Foundation
import AdventOfCode2020Lib

guard CommandLine.arguments.count >= 2 else {
    print("Please specify a problem to run")
    exit(1)
}

let problem = CommandLine.arguments[1]

switch problem {
case "day1":
    guard CommandLine.arguments.count >= 3 else {
        print("Please specify an input file")
        exit(1)
    }
    let file = CommandLine.arguments[2]
    let fixer = ExpenseReportFixer()

    let entries = fixer.readExpenseReport(from: file)
    print(fixer.analyze(entries: entries))
default:
    print("Problem \(problem) not found")
}
