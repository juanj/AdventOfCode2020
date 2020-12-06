import XCTest
@testable import AdventOfCode2020Lib

final class CustomsUtilsTests: XCTestCase {
    func testLoadAnswers_withTestInput_loadsCorrectly() {
        let input = """
        abc

        a
        b
        c

        ab
        ac

        a
        a
        a
        a

        b
        """
        let utils = CustomsUtils()

        let answers = utils.loadAnswers(from: input)

        XCTAssertEqual(answers, [[["a", "b", "c"]], [["a"], ["b"], ["c"]], [["a", "b"], ["a", "c"]], [["a"], ["a"], ["a"], ["a"]], [["b"]]])
    }

    func testUniqueAnswers_withTestInput_combinesCorrectly() {
        let input: [[Set<Character>]] = [[["a", "b", "c"]], [["a"], ["b"], ["c"]], [["a", "b"], ["a", "c"]], [["a"], ["a"], ["a"], ["a"]], [["b"]]]
        let utils = CustomsUtils()

        let unique = utils.uniqueAnswers(groups: input)

        XCTAssertEqual(unique, [["a", "b", "c"], ["a", "b", "c"], ["a", "b", "c"], ["a"], ["b"]])
    }

    func testCommonAnswers_withTestInput_combinesCorrectly() {
        let input: [[Set<Character>]] = [[["a", "b", "c"]], [["a"], ["b"], ["c"]], [["a", "b"], ["a", "c"]], [["a"], ["a"], ["a"], ["a"]], [["b"]]]
        let utils = CustomsUtils()

        let common = utils.commonAnswers(groups: input)

        XCTAssertEqual(common, [["a", "b", "c"], [], ["a"], ["a"], ["b"]])
    }
}
