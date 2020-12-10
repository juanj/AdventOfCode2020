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
    func testLoad_fromTestString_loadsAllAdapters() {
        let utils = JoltAdapterUtils()

        let adapters = utils.load(from: testInput)

        XCTAssertEqual(adapters, [16, 10, 15, 5, 1, 11, 7, 19, 6, 12, 4])
    }

    func testGetSteps_fromTestString_returnCorrectSteps() {
        let utils = JoltAdapterUtils()

        let steps = utils.getSteps(adapters: [16, 10, 15, 5, 1, 11, 7, 19, 6, 12, 4])

        XCTAssertEqual(steps, [1, 3, 1, 1, 1, 3, 1, 1, 3, 1, 3, 3])
    }
}
