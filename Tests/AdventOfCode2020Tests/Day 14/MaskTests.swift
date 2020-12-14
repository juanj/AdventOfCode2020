import XCTest
@testable import AdventOfCode2020Lib

final class MaskTests: XCTestCase {
    func testInit_fromString_initsOnesMaskCorrectly() {
        let input = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X"

        let mask = Mask(from: input)

        XCTAssertEqual(String(mask.onesMask, radix: 2), String(0b0000_0000_0000_0000_0000_0000_0000_0100_0000, radix: 2))
    }

    func testInit_fromString_initsZerosMaskCorrectly() {
        let input = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X"

        let mask = Mask(from: input)

        XCTAssertEqual(String(mask.zerosMask, radix: 2), String(0b1111_1111_1111_1111_1111_1111_1111_1111_1101, radix: 2))
    }

    func testApply_withTestInput_onesMaskIsApplied() {
        let input = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X"
        let mask = Mask(from: input)

        let masked = mask.apply(to: 0b0000_0000_0000_0000_0000_0000_0000_0000_0000)

        XCTAssertEqual(String(masked, radix: 2), String(0b0000_0000_0000_0000_0000_0000_0000_0100_0000, radix: 2))
    }

    func testApply_withTestInput_zerosMaskIsApplied() {
        let input = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X"
        let mask = Mask(from: input)

        let masked = mask.apply(to: 0b1111_1111_1111_1111_1111_1111_1111_1111_1111)

        XCTAssertEqual(String(masked, radix: 2), String(0b1111_1111_1111_1111_1111_1111_1111_1111_1101, radix: 2))
    }

    func testApply_withDecimalValue_masksToCorrectValue() {
        let input = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X"
        let mask = Mask(from: input)

        let masked = mask.apply(to: 11)

        XCTAssertEqual(masked, 73)
    }
}
