import XCTest
@testable import AdventOfCode2020Lib

final class TrainTicketUtilsTests: XCTestCase {
    func testLoad_withTestInput_loadsAllTheFields() {
        let input = """
        class: 1-3 or 5-7
        row: 6-11 or 33-44
        seat: 13-40 or 45-50

        your ticket:
        7,1,14

        nearby tickets:
        7,3,47
        40,4,50
        55,2,20
        38,6,12
        """
        let utils = TrainTicketUtils()

        let notes = utils.load(from: input)

        XCTAssertEqual([notes].description, [TrainTicketNotes(fields: [
            .init(name: "class", rules: [1...3, 5...7]),
            .init(name: "row", rules: [6...11, 33...44]),
            .init(name: "seat", rules: [13...40, 45...50])
        ], yourTicket: [7, 1, 14], nearbyTickets: [
            [7, 3, 47],
            [40, 4, 50],
            [55, 2, 20],
            [38, 6, 12]
        ])].description)
    }

    func testInvalidNumbers_withOneInvalidNumber_returnsTheInvalidNumber() {
        let utils = TrainTicketUtils()
        let notes = TrainTicketNotes(fields: [.init(name: "Test", rules: [1...5, 7...10])], yourTicket: [1], nearbyTickets: [[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]])

        let invalidNumbers = utils.invalidNumbers(notes: notes)

        XCTAssertEqual(invalidNumbers, [6])
    }

    func testInvalidNumbers_withTestInput_returns4and55and12() {
        let input = """
        class: 1-3 or 5-7
        row: 6-11 or 33-44
        seat: 13-40 or 45-50

        your ticket:
        7,1,14

        nearby tickets:
        7,3,47
        40,4,50
        55,2,20
        38,6,12
        """
        let utils = TrainTicketUtils()
        let notes = utils.load(from: input)

        let invalidNumbers = utils.invalidNumbers(notes: notes)

        XCTAssertEqual(invalidNumbers, [4, 55, 12])
    }

    func testValidTickets_withTestInput_returnsFirstTicket() {
        let input = """
        class: 1-3 or 5-7
        row: 6-11 or 33-44
        seat: 13-40 or 45-50

        your ticket:
        7,1,14

        nearby tickets:
        7,3,47
        40,4,50
        55,2,20
        38,6,12
        """
        let utils = TrainTicketUtils()
        let notes = utils.load(from: input)

        let validTickets = utils.validTickets(notes: notes)

        XCTAssertEqual(validTickets, [[7, 3, 47]])
    }
}
