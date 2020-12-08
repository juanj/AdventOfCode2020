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
}
