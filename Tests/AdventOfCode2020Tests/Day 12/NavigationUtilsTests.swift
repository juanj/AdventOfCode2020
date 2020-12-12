import XCTest
@testable import AdventOfCode2020Lib

final class NavigationUtilsTests: XCTestCase {
    func testExecuteNavigation_withTestInput_givesManhattanDistance25() {
        let input = """
        F10
        N3
        F7
        R90
        F11
        """
        let utils = NavigationUtils()
        let instructions = utils.loadInstructions(from: input)

        let position = utils.executeNavigation(instructions: instructions)

        XCTAssertEqual(position.manhattanDistance, 25)
    }

    func testExecuteWaypointNavigation_withTestInput_givesManhattanDistance25() {
        let input = """
        F10
        N3
        F7
        R90
        F11
        """
        let utils = NavigationUtils()
        let instructions = utils.loadInstructions(from: input)

        let position = utils.executeWaypointNavigation(instructions: instructions, initialWayPont: Position(northSouth: 1, eastWest: 10, angle: 0))

        XCTAssertEqual(position.manhattanDistance, 286)
    }
}
