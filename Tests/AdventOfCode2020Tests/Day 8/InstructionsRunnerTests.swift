import XCTest
@testable import AdventOfCode2020Lib

final class InstructionsRunnerTests: XCTestCase {
    func testRunUntilLoop_withTestInput_returnsAcc5() {
        let input = """
        nop +0
        acc +1
        jmp +4
        acc +3
        jmp -3
        acc -99
        acc +1
        jmp -4
        acc +6
        """
        let parser = InstructionsParser()
        let instructions = parser.parse(file: input)
        let runner = InstructionsRunner()

        let acc = runner.runUntilLoop(instructions: instructions)

        XCTAssertEqual(acc, 5)
    }

    func testIsLoop_withTestInput_returnsTrue() {
        let input = """
        nop +0
        acc +1
        jmp +4
        acc +3
        jmp -3
        acc -99
        acc +1
        jmp -4
        acc +6
        """
        let parser = InstructionsParser()
        let instructions = parser.parse(file: input)
        let runner = InstructionsRunner()

        let isLoop = runner.isLoop(instructions: instructions)

        XCTAssertTrue(isLoop)
    }

    func testIsLoop_withFixedTestInput_returnsFalse() {
        let input = """
        nop +0
        acc +1
        jmp +4
        acc +3
        jmp -3
        acc -99
        acc +1
        nop -4
        acc +6
        """
        let parser = InstructionsParser()
        let instructions = parser.parse(file: input)
        let runner = InstructionsRunner()

        let isLoop = runner.isLoop(instructions: instructions)

        XCTAssertFalse(isLoop)
    }

    func testFixInfiniteLoop_withTestInput_returnsCorrectInstructions() {
        let fixedInput = """
        nop +0
        acc +1
        jmp +4
        acc +3
        jmp -3
        acc -99
        acc +1
        nop -4
        acc +6
        """
        let badInput = """
        nop +0
        acc +1
        jmp +4
        acc +3
        jmp -3
        acc -99
        acc +1
        jmp -4
        acc +6
        """

        let parser = InstructionsParser()
        let goodInstructions = parser.parse(file: fixedInput)
        let badInstructions = parser.parse(file: badInput)
        let runner = InstructionsRunner()

        let fixedInstructions = runner.fixInfiniteLoop(instructions: badInstructions)

        XCTAssertEqual(fixedInstructions, goodInstructions)
    }

    func testRun_withCorrectInput_returnsAcc8() {
        let fixedInput = """
        nop +0
        acc +1
        jmp +4
        acc +3
        jmp -3
        acc -99
        acc +1
        nop -4
        acc +6
        """

        let parser = InstructionsParser()
        let instructions = parser.parse(file: fixedInput)
        let runner = InstructionsRunner()

        let acc = runner.run(instructions: instructions)

        XCTAssertEqual(acc, 8)
    }
}
