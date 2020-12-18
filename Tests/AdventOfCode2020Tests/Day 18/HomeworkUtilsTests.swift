import XCTest
@testable import AdventOfCode2020Lib

final class HomeworkUtilsTests: XCTestCase {
    func testTokenize_withTestInput_returnsTokensSequence() {
        let input = "1 + 2 * 3 + 4 * 5 + 6"
        let utils = HomeworkUtils()

        let tokens = utils.tokenize(input)

        XCTAssertEqual(tokens, [.number(1), .add, .number(2), .mul, .number(3), .add, .number(4), .mul, .number(5), .add, .number(6)])
    }

    func testTokenize_withParenthesis_returnsTokensSequence() {
        let input = "1 + 2 * 3 + (4 * 5 + 6)"
        let utils = HomeworkUtils()

        let tokens = utils.tokenize(input)

        XCTAssertEqual(tokens, [.number(1), .add, .number(2), .mul, .number(3), .add, .lparen,.number(4), .mul, .number(5), .add, .number(6), .rparen])
    }

    func testReorder_withInfixNotation_returnsPosfixNotation() {
        let input = "1 + 2 * 3 + 4 * 5 + 6" // -> 1 2 + 3 * 4 + 5 * 6 +

        let utils = HomeworkUtils()
        let tokens = utils.tokenize(input)

        let posfixNotation = utils.reorder(tokens: tokens)

        XCTAssertEqual(posfixNotation, [.number(1), .number(2), .add, .number(3), .mul, .number(4), .add, .number(5), .mul, .number(6), .add])
    }

    func testReorder_withParenthesisInfixNotation_returnsPosfixNotation() {
        let input = "1 + (2 * 3) + (4 * (5 + 6))" // -> 1 2 3 * + 4 5 6 + * +

        let utils = HomeworkUtils()
        let tokens = utils.tokenize(input)

        let posfixNotation = utils.reorder(tokens: tokens)

        XCTAssertEqual(posfixNotation, [.number(1), .number(2), .number(3), .mul, .add, .number(4), .number(5), .number(6), .add, .mul, .add])
    }

    func testExecute_plainExpression_returns71() {
        let input = "1 + 2 * 3 + 4 * 5 + 6" // -> 1 2 + 3 * 4 + 5 * 6 +

        let utils = HomeworkUtils()
        let tokens = utils.tokenize(input)
        let posfixNotation = utils.reorder(tokens: tokens)

        let result = utils.execute(tokens: posfixNotation)

        XCTAssertEqual(result, 71)
    }

    func testReorder_withParenthesisExpression_returnsPosfixNotation() {
        let input = "1 + (2 * 3) + (4 * (5 + 6))" // -> 1 2 3 * + 4 5 6 + * +

        let utils = HomeworkUtils()
        let tokens = utils.tokenize(input)
        let posfixNotation = utils.reorder(tokens: tokens)

        let result = utils.execute(tokens: posfixNotation)

        XCTAssertEqual(result, 51)
    }
}
