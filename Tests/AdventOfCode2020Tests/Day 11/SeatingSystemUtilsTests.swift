import XCTest
@testable import AdventOfCode2020Lib

final class SeatingSystemUtilsTests: XCTestCase {
    func testInSightOccupied_onlayAdjacentWithFullSeats_returns8() {
        let input = """
        ###
        ###
        ###
        """
        let utils = SeatingSystemUtils()
        let seats = utils.load(from: input)

        let occupied = utils.inSightOccupied(seats: seats, row: 1, column: 1, onlyAdjacent: true)

        XCTAssertEqual(occupied, 8)
    }

    func testStep_withAllEmptySeats_returnsAllSeatsOccupied() {
        let input = """
        LLL
        LLL
        LLL
        """
        let utils = SeatingSystemUtils()
        let seats = utils.load(from: input)

        let newState = utils.step(seats: seats)

        XCTAssertEqual(newState, Array(repeating: Array(repeating: SeatState.occupied, count: 3), count: 3))
    }

    func testInSightOccupied_with8SeatsInSight_returns8() {
        let input = """
        .......#.
        ...#.....
        .#.......
        .........
        ..#L....#
        ....#....
        .........
        #........
        ...#.....
        """
        let utils = SeatingSystemUtils()
        let seats = utils.load(from: input)

        let occupied = utils.inSightOccupied(seats: seats, row: 4, column: 3)

        XCTAssertEqual(occupied, 8)
    }

    func testInSightOccupied_withOccupiedSeatBehaindEmptySeat_returns0() {
        let input = """
        .............
        .L.L.#.#.#.#.
        .............
        """
        let utils = SeatingSystemUtils()
        let seats = utils.load(from: input)

        let occupied = utils.inSightOccupied(seats: seats, row: 1, column: 1)

        XCTAssertEqual(occupied, 0)
    }
}
