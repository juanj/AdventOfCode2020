import XCTest
@testable import AdventOfCode2020Lib

final class ExpenseReportFixerTests: XCTestCase {
    func testAnalyze_withEmptyArray_returnsZero() {
        let fixer = ExpenseReportFixer()

        let result = fixer.analyze(entries: [])

        XCTAssertEqual(result, 0)
    }

    func testAnalyze_withTwoItemsEqualToTarget_returnsProduct() {
        let fixer = ExpenseReportFixer()

        let result = fixer.analyze(entries: [2, 2], target: 4)

        XCTAssertEqual(result, 4)
    }

    func testAnalyze_withTwoItemsEqualToTargetAndOneExtraItem_returnsProduct() {
        let fixer = ExpenseReportFixer()

        let result = fixer.analyze(entries: [1, 2, 2], target: 4)

        XCTAssertEqual(result, 4)
    }

    func testAnalyze_withOddNumberOfItems_returnsProduct() {
        let fixer = ExpenseReportFixer()

        let result = fixer.analyze(entries: [21, 1, 3, 30, 10, 15, 20], target: 50)

        XCTAssertEqual(result, 600)
    }

    func testAnalyze_withEventNumberOfItems_returnsProduct() {
        let fixer = ExpenseReportFixer()

        let result = fixer.analyze(entries: [1, 3, 5, 7, 10, 15, 30, 20], target: 50)

        XCTAssertEqual(result, 600)
    }

    func testAnalyze_addingThree_returnsProduct() {
        let fixer = ExpenseReportFixer()

        let result = fixer.analyze(entries: [1, 2, 7], target: 10, adding: 3)

        XCTAssertEqual(result, 14)
    }

    func testAnalyze_addingThreeWithMultipleNumbers_returnsProduct() {
        let fixer = ExpenseReportFixer()

        let result = fixer.analyze(entries: [50, 3, 20, 5, 7, 34, 98, 11, 3, 1, 300], target: 112, adding: 3)

        XCTAssertEqual(result, 3234)
    }

    static var allTests = [
        ("testAnalyze_withEmptyArray_returnsZero", testAnalyze_withEmptyArray_returnsZero),
    ]
}
