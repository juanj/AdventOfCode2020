import XCTest
@testable import AdventOfCode2020Lib

final class NavigationInstructionTests: XCTestCase {
    func testExecute_withW5_updatesPosition() {
        let instruction = NavigationInstruction(action: .west, value: 5)
        let position = Position(northSouth: 0, eastWest: 0, angle: 0)

        let newPosition = instruction.execute(position)

        XCTAssertEqual(newPosition, Position(northSouth: 0, eastWest: -5, angle: 0))
    }

    func testExecute_withE5_updatesPosition() {
        let instruction = NavigationInstruction(action: .east, value: 5)
        let position = Position(northSouth: 0, eastWest: 0, angle: 0)

        let newPosition = instruction.execute(position)

        XCTAssertEqual(newPosition, Position(northSouth: 0, eastWest: 5, angle: 0))
    }

    func testExecute_withN5_updatesPosition() {
        let instruction = NavigationInstruction(action: .north, value: 5)
        let position = Position(northSouth: 0, eastWest: 0, angle: 0)

        let newPosition = instruction.execute(position)

        XCTAssertEqual(newPosition, Position(northSouth: 5, eastWest: 0, angle: 0))
    }

    func testExecute_withS5_updatesPosition() {
        let instruction = NavigationInstruction(action: .south, value: 5)
        let position = Position(northSouth: 0, eastWest: 0, angle: 0)

        let newPosition = instruction.execute(position)

        XCTAssertEqual(newPosition, Position(northSouth: -5, eastWest: 0, angle: 0))
    }

    func testExecute_withR5_updatesPosition() {
        let instruction = NavigationInstruction(action: .right, value: 5)
        let position = Position(northSouth: 0, eastWest: 0, angle: 0)

        let newPosition = instruction.execute(position)

        XCTAssertEqual(newPosition, Position(northSouth: 0, eastWest: 0, angle: 5))
    }

    func testExecute_withL5_updatesPosition() {
        let instruction = NavigationInstruction(action: .left, value: 5)
        let position = Position(northSouth: 0, eastWest: 0, angle: 0)

        let newPosition = instruction.execute(position)

        XCTAssertEqual(newPosition, Position(northSouth: 0, eastWest: 0, angle: 355))
    }

    func testExecute_withAngle90F5_updatesPosition() {
        let instruction = NavigationInstruction(action: .forward, value: 5)
        let position = Position(northSouth: 0, eastWest: 0, angle: 90)

        let newPosition = instruction.execute(position)

        XCTAssertEqual(newPosition, Position(northSouth: -5, eastWest: 0, angle: 90))
    }

    func testUpdateWaypoint_withAngleR180_rotatesWaypoint() {
        let instruction = NavigationInstruction(action: .right, value: 180)
        let position = Position(northSouth: 1, eastWest: 1, angle: 0)

        let newPosition = instruction.updateWaypoint(position)

        XCTAssertEqual(newPosition, Position(northSouth: -1, eastWest: -1, angle: 0))
    }

    func testUpdateWaypoint_withAngleR90_rotatesWaypoint() {
        let instruction = NavigationInstruction(action: .right, value: 90)
        let position = Position(northSouth: 1, eastWest: 1, angle: 0)

        let newPosition = instruction.updateWaypoint(position)

        XCTAssertEqual(newPosition, Position(northSouth: -1, eastWest: 1, angle: 0))
    }


    func testUpdateWaypoint_withAngleL180_rotatesWaypoint() {
        let instruction = NavigationInstruction(action: .left, value: 180)
        let position = Position(northSouth: 1, eastWest: 1, angle: 0)

        let newPosition = instruction.updateWaypoint(position)

        XCTAssertEqual(newPosition, Position(northSouth: -1, eastWest: -1, angle: 0))
    }

    func testUpdateWaypoint_withAngleL90_rotatesWaypoint() {
        let instruction = NavigationInstruction(action: .left, value: 90)
        let position = Position(northSouth: 1, eastWest: 1, angle: 0)

        let newPosition = instruction.updateWaypoint(position)

        XCTAssertEqual(newPosition, Position(northSouth: 1, eastWest: -1, angle: 0))
    }
}
