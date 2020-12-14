import XCTest
@testable import AdventOfCode2020Lib

final class MemoryUtilsTests: XCTestCase {
    func testLoad_withTestInput_loadsOperations() {
        let input = """
        mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X
        mem[8] = 11
        mem[7] = 101
        mem[9] = 0
        """
        let utils = MemoryUtils()

        let operations = utils.load(from: input)

        XCTAssertEqual(operations.description, [MemoryOperation(mask: Mask(from: "XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X"), assignments: [(8, 11), (7, 101), (9, 0)])].description)
    }

    func testLoad_withMultipleOperations_loadsOperations() {
        let input = """
        mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X
        mem[8] = 11
        mem[7] = 101
        mem[9] = 0
        mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX0XXXX0X
        mem[8] = 11
        mem[7] = 101
        mem[9] = 0
        """
        let utils = MemoryUtils()

        let operations = utils.load(from: input)

        XCTAssertEqual(operations.description, [MemoryOperation(mask: Mask(from: "XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X"), assignments: [(8, 11), (7, 101), (9, 0)]),
                                    MemoryOperation(mask: Mask(from: "XXXXXXXXXXXXXXXXXXXXXXXXXXXXX0XXXX0X"), assignments: [(8, 11), (7, 101), (9, 0)])].description)
    }
}
