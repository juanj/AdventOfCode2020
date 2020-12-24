import XCTest
@testable import AdventOfCode2020Lib

final class TilesUtilsTests: XCTestCase {
    func testTileLocationAfter_testInput_returnsCorrectLocation() {
        let input = "esenee"
        let utils = TilesUtils()
        let directions = utils.load(from: input)[0]

        let location = utils.tileLocationAfter(directions: directions)

        XCTAssertEqual([location].description, [TileLocation(x: 3, y: -3, z: 0)].description)
    }
}
