import Foundation
import ArgumentParser
import AdventOfCode2020Lib

enum Day: String, ExpressibleByArgument {
    case day1, day2, day3, day4, day5, day6, day7, day8, day9, day10, day11, day12, day13, day14
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
        case .day9:
            executer = Day9Executer()
        case .day10:
            executer = Day10Executer()
        case .day11:
            executer = Day11Executer()
        case .day12:
            executer = Day12Executer()
        case .day13:
            executer = Day13Executer()
        case .day14:
            executer = Day14Executer()
        }

        let startTime = CFAbsoluteTimeGetCurrent()
        executer.execute(with: inputFile)
        let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
        print("It took \(timeElapsed * 1000)ms")
    }
}

Runner.main()
