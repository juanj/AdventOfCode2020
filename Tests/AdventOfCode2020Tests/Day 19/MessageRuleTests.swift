import XCTest
@testable import AdventOfCode2020Lib

final class ConcreteMessageRuleTests: XCTestCase {
    func testMatch_withValidInput_returnsEmptyString() {
        let rule = ConcreteMessageRule("a")

        let consumedString = rule.match("a")

        XCTAssertEqual(consumedString, "")
    }

    func testMatch_withValidFirstCharacter_returnsRemainingString() {
        let rule = ConcreteMessageRule("a")

        let consumedString = rule.match("aaa")

        XCTAssertEqual(consumedString, "aa")
    }

    func testMatch_withInvalidInput_returnsInputString() {
        let rule = ConcreteMessageRule("a")

        let consumedString = rule.match("b")

        XCTAssertEqual(consumedString, "b")
    }
}
