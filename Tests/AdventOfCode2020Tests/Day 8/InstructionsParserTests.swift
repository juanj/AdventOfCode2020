import XCTest
@testable import AdventOfCode2020Lib

final class InstructionsParserTests: XCTestCase {
    func testParse_withSingleNopInstruction_parsesCorrectly() {
        let input = "nop +0"
        let parser = InstructionsParser()

        let instructions = parser.parse(file: input)

        XCTAssertEqual(instructions, [Instruction(type: .nop, value: 0)])
    }

    func testParse_withSingleAccInstruction_parsesCorrectly() {
        let input = "acc +1"
        let parser = InstructionsParser()

        let instructions = parser.parse(file: input)

        XCTAssertEqual(instructions, [Instruction(type: .acc, value: 1)])
    }

    func testParse_withSingleJmpInstruction_parsesCorrectly() {
        let input = "jmp +4"
        let parser = InstructionsParser()

        let instructions = parser.parse(file: input)

        XCTAssertEqual(instructions, [Instruction(type: .jmp, value: 4)])
    }
}
