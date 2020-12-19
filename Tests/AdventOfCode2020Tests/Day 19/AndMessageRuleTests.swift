import XCTest
@testable import AdventOfCode2020Lib

final class AndMessageRuleTests: XCTestCase {
    func testMatch_withValidInput_returnsEmptyString() {
        let andRule = AndMessageRule(rules: [ConcreteMessageRule("a"), ConcreteMessageRule("a")])

        let consumedString = andRule.match("aab")

        XCTAssertEqual(consumedString, "b")
    }

    func testMatch_withPartValidInput_returnsInputString() {
        let andRule = AndMessageRule(rules: [ConcreteMessageRule("a"), ConcreteMessageRule("b")])

        let consumedString = andRule.match("aa")

        XCTAssertEqual(consumedString, "aa")
    }

    func testMatch_withInvalidInput_returnsInputString() {
        let andRule = AndMessageRule(rules: [ConcreteMessageRule("b"), ConcreteMessageRule("b")])

        let consumedString = andRule.match("aa")

        XCTAssertEqual(consumedString, "aa")
    }
}
