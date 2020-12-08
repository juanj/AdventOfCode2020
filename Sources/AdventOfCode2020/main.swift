import Foundation
import ArgumentParser
import AdventOfCode2020Lib

enum Day: String, ExpressibleByArgument {
    case day1, day2, day3, day4, day5, day6, day7, day8
}

struct Runner: ParsableCommand {
    @Argument
    var day: Day

    @Option
    var input: String

    func run() throws {
        let inputFile = try String(contentsOfFile: input)
        let executer: Executer
        switch day {
        case .day1:
            executer = Day1Executer()
        case .day2:
            executer = Day2Executer()
        case .day3:
            executer = Day3Executer()
        case .day4:
            executer = Day4Executer()
        case .day5:
            executer = Day5Executer()
        case .day6:
            executer = Day6Executer()
        case .day7:
            executer = Day7Executer()
        case .day8:
            executer = Day8Executer()
        }
        executer.execute(with: inputFile)
    }
}

Runner.main()
