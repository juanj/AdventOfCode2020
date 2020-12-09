import XCTest
@testable import AdventOfCode2020Lib

final class EncriptedCodeUtilsTests: XCTestCase {
    func testIsValid_withTestInputPosition14_returnsFalse() {
        let input = """
        35
        20
        15
        25
        47
        40
        62
        55
        65
        95
        102
        117
        150
        182
        127
        219
        299
        277
        309
        576
        """
        let utils = EncriptedCodeUtils()
        let code = utils.importCode(from: input)

        let valid = utils.isValid(code: code, position: 14, preamble: 5)

        XCTAssertFalse(valid)
    }

    func testIsValid_withTestInputNoPosition14_returnsTrue() {
        let input = """
        35
        20
        15
        25
        47
        40
        62
        55
        65
        95
        102
        117
        150
        182
        127
        219
        299
        277
        309
        576
        """
        let utils = EncriptedCodeUtils()
        let code = utils.importCode(from: input)

        let valid = utils.isValid(code: code, position: 10, preamble: 5)

        XCTAssertTrue(valid)
    }

    func testFindSequenceOfNumbers_withTestInput_returnsCorrectSequence() {
        let input = """
        35
        20
        15
        25
        47
        40
        62
        55
        65
        95
        102
        117
        150
        182
        127
        219
        299
        277
        309
        576
        """
        let utils = EncriptedCodeUtils()
        let code = utils.importCode(from: input)

        let sequence = utils.findSequenceOfNumbers(code: code, sum: 127)

        XCTAssertEqual(sequence, [15, 25, 47, 40])
    }
}
