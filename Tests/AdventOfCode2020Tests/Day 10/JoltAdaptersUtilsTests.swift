import XCTest
@testable import AdventOfCode2020Lib

final class JoltAdaptersUtilsTests: XCTestCase {
    let testInput = """
    16
    10
    15
    5
    1
    11
    7
    19
    6
    12
    4
    """

    let longTestInput = """
    28
    33
    18
    42
    31
    14
    46
    20
    48
    47
    24
    23
    49
    45
    19
    38
    39
    11
    1
    32
    25
    35
    8
    17
    7
    9
    4
    2
    34
    10
    3
    """
    func testLoad_fromTestString_loadsAllAdapters() {
        let utils = JoltAdapterUtils()

        let adapters = utils.load(from: testInput)

        XCTAssertEqual(adapters, [16, 10, 15, 5, 1, 11, 7, 19, 6, 12, 4])
    }

    func testLoad_fromLongTestString_loadsAllAdapters() {
        let utils = JoltAdapterUtils()

        let adapters = utils.load(from: longTestInput)

        XCTAssertEqual(adapters, [28, 33, 18, 42, 31, 14, 46, 20, 48, 47, 24, 23, 49, 45, 19, 38, 39, 11, 1, 32, 25, 35, 8, 17, 7, 9, 4, 2, 34, 10, 3])
    }

    func testGetSteps_fromTestString_returnCorrectSteps() {
        let utils = JoltAdapterUtils()

        let steps = utils.getSteps(adapters: [16, 10, 15, 5, 1, 11, 7, 19, 6, 12, 4])

        XCTAssertEqual(steps, [1, 3, 1, 1, 1, 3, 1, 1, 3, 1, 3, 3])
    }

    func testGetSteps_fromLongTestString_returnCorrectSteps() {
        let utils = JoltAdapterUtils()

        let steps = utils.getSteps(adapters: utils.load(from: longTestInput))

        XCTAssertEqual(steps.filter { $0 == 1 }.count, 22)
        XCTAssertEqual(steps.filter { $0 == 3 }.count, 10)
    }

    func testCompressSteps_withTestInput_returnsCompresedSteps() {
        let utils = JoltAdapterUtils()

        let compressed = utils.compressSteps(steps: [1, 3, 1, 1, 1, 3, 1, 1, 3, 1, 3, 3])

        XCTAssertEqual(compressed.description, [(1, 1), (3, 1), (1, 3), (3, 1), (1, 2), (3, 1), (1, 1), (3, 2)].description)
    }

    func testGetNumberOfCombinations_withTestInput_returns8() {
        let utils = JoltAdapterUtils()

        let adapters = utils.load(from: testInput)
        let combinations = utils.getNumberOfCombinations(adapters: adapters)

        XCTAssertEqual(combinations, 8)
    }

    func testGetNumberOfCombinations_withLongTestInput_returns19208() {
        let utils = JoltAdapterUtils()

        let adapters = utils.load(from: longTestInput)
        let combinations = utils.getNumberOfCombinations(adapters: adapters)

        XCTAssertEqual(combinations, 19208)
    }
}
