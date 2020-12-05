import XCTest
@testable import AdventOfCode2020Lib

final class BoardingPassTests: XCTestCase {
    func testInit_fromBoardingPass_decodesCorrectly() {
        let boardingPass = BoardingPass(from: "FBFBBFFRLR")

        XCTAssertEqual(boardingPass.row, 44)
        XCTAssertEqual(boardingPass.column, 5)
    }

    func testId_withRow44Column5_returns220() {
        let boardingPass = BoardingPass(from: "FBFBBFFRLR")

        XCTAssertEqual(boardingPass.id, 357)
    }
}
