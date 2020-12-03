import XCTest
@testable import AdventOfCode2020Lib

final class NavigatorTests: XCTestCase {
    func testParseMap_withSampleImput_parsesMapCorrectly() {
        let input = """
        ..##..
        #...#.
        .#....
        """
        let navigator = Navigator()

        let result = navigator.parseMap(input)

        XCTAssertEqual(result, [
            [0, 0, 1, 1, 0, 0],
            [1, 0, 0, 0, 1, 0],
            [0, 1, 0, 0, 0, 0]
            ])
    }

    func testTreesInPath_withSampleImput_returnsNumberOfTrees() {
        let input = """
        ..##.......
        #...#...#..
        .#....#..#.
        """
        let navigator = Navigator()

        let numberOfTrees = navigator.treesInPath(map: navigator.parseMap(input))

        XCTAssertEqual(numberOfTrees, 1)
    }

    func testTreesInPath_afterOverflow_returnsNumberOfTrees() {
        let input = """
        ..##.......
        #...#...#..
        .#....#..#.
        ..#.#...#.#
        .#...##..#.
        ..#.##.....
        .#.#.#....#
        .#........#
        #.##...#...
        #...##....#
        .#..#...#.#
        """
        let navigator = Navigator()

        let numberOfTrees = navigator.treesInPath(map: navigator.parseMap(input))

        XCTAssertEqual(numberOfTrees, 7)
    }

    func testThreesInPath_with5RightStep_returnsNumberOfTrees() {
        let input = """
        .........
        .....#...
        .#.......
        ......#..
        """
        let navigator = Navigator()

        let numberOfTrees = navigator.treesInPath(map: navigator.parseMap(input), stepsRight: 5)

        XCTAssertEqual(numberOfTrees, 3)
    }

    func testTreesInPath_with3StepDown_returnsNumberOfTrees() {
        let input = """
        ....
        ...#
        ...#
        ...#
        ....
        ....
        ..#.
        """
        let navigator = Navigator()

        let numberOfTrees = navigator.treesInPath(map: navigator.parseMap(input), stepsDown: 3)

        XCTAssertEqual(numberOfTrees, 2)
    }
}
