import XCTest
@testable import AdventOfCode2020Lib

final class OrMessageRuleTests: XCTestCase {
    func testMatch_withValidInput_returnsEmptyString() {
        let andRule = OrMessageRule(rules: [ConcreteMessageRule("a"), ConcreteMessageRule("b")])

        let consumedString = andRule.match("a")

        XCTAssertEqual(consumedString, "")
    }

    func testMatch_withInvalidInput_returnsInputString() {
        let andRule = OrMessageRule(rules: [ConcreteMessageRule("b"), ConcreteMessageRule("b")])

        let consumedString = andRule.match("a")

        XCTAssertEqual(consumedString, "a")
    }
}
