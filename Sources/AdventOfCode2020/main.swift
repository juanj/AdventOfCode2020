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
    var adding = 2
    if CommandLine.arguments.count >= 4, let number = Int(CommandLine.arguments[3]) {
        adding = number
    }
    let fixer = ExpenseReportFixer()

    let entries = fixer.readExpenseReport(from: file)
    print(fixer.analyze(entries: entries, adding: adding))
case "day2":
    guard CommandLine.arguments.count >= 3 else {
        print("Please specify an input file")
        exit(1)
    }

    let file = CommandLine.arguments[2]
    let validator = PasswordValidator()
    let password = validator.readPasswordsList(from: file)
    print(password.filter { validator.validateToboggan($0) }.count)
case "day3":
    guard CommandLine.arguments.count >= 3 else {
        print("Please specify an input file")
        exit(1)
    }

    let file = CommandLine.arguments[2]
    let navigator = Navigator()
    let map = navigator.loadMap(from: file)
    let slopes = [[1, 1], [3, 1], [5, 1], [7, 1], [1, 2]]
    var result = 1
    for slope in slopes {
        let trees = navigator.treesInPath(map: map, stepsRight: slope[0], stepsDown: slope[1])
        print("Trees with slope \(slope[0]) right, \(slope[1]) down: \(trees)")
        result *= trees
    }
    print("Result: \(result)")
case "day4":
    guard CommandLine.arguments.count >= 3 else {
        print("Please specify an input file")
        exit(1)
    }

    let file = CommandLine.arguments[2]
    let loader = CredentialLoader()
    let credentials = loader.loadBatch(from: file)
    print(credentials.map { $0.isValid() }.filter { $0 }.count)
default:
    print("Problem \(problem) not found")
}
