import XCTest
@testable import AdventOfCode2020Lib

final class MemoryGameUtilsTests: XCTestCase {
    func testNextTurn_firstTimeNumber_returnsNextNumber0() {
        let utils = MemoryGameUtils()
        var gameState = [1: 1, 2: 2]
        var currentTurn = 4
        var lastNumber = 3

        utils.nextTurn(gameState: &gameState, currentTurn: &currentTurn, lastNumber: &lastNumber)

        XCTAssertEqual(lastNumber, 0)
    }

    func testNextTurn_firstTimeNumber_updatesGameStateWithPreviousNumber() {
        let utils = MemoryGameUtils()
        var gameState = [1: 1, 2: 2]
        var currentTurn = 4
        var lastNumber = 3

        utils.nextTurn(gameState: &gameState, currentTurn: &currentTurn, lastNumber: &lastNumber)

        XCTAssertEqual(gameState[3], 3)
    }

    func testNextTurn_afterSequenceOfTurns_stateIsCorrect() {
        let utils = MemoryGameUtils()
        var gameState = [0: 1, 3: 2]
        var currentTurn = 4
        var lastNumber = 6

        utils.nextTurn(gameState: &gameState, currentTurn: &currentTurn, lastNumber: &lastNumber)
        utils.nextTurn(gameState: &gameState, currentTurn: &currentTurn, lastNumber: &lastNumber)
        utils.nextTurn(gameState: &gameState, currentTurn: &currentTurn, lastNumber: &lastNumber)

        XCTAssertEqual(lastNumber, 3)
    }

    func testNextTurn_afterLongSequenceOfTurns_stateIsCorrect() {
        let utils = MemoryGameUtils()
        var gameState = [0: 1, 3: 2]
        var currentTurn = 4
        var lastNumber = 6

        utils.nextTurn(gameState: &gameState, currentTurn: &currentTurn, lastNumber: &lastNumber)
        utils.nextTurn(gameState: &gameState, currentTurn: &currentTurn, lastNumber: &lastNumber)
        utils.nextTurn(gameState: &gameState, currentTurn: &currentTurn, lastNumber: &lastNumber)
        utils.nextTurn(gameState: &gameState, currentTurn: &currentTurn, lastNumber: &lastNumber)
        utils.nextTurn(gameState: &gameState, currentTurn: &currentTurn, lastNumber: &lastNumber)
        utils.nextTurn(gameState: &gameState, currentTurn: &currentTurn, lastNumber: &lastNumber)
        utils.nextTurn(gameState: &gameState, currentTurn: &currentTurn, lastNumber: &lastNumber)

        XCTAssertEqual(lastNumber, 0)
    }

    func testNextTurn_withTestInput1_numberAt2020is436() {
        let utils = MemoryGameUtils()
        var gameState = [0: 1, 3: 2]
        var currentTurn = 4
        var lastNumber = 6

        while currentTurn <= 2020 {
            utils.nextTurn(gameState: &gameState, currentTurn: &currentTurn, lastNumber: &lastNumber)
        }

        XCTAssertEqual(lastNumber, 436)
    }

    func testNextTurn_withTestInput2_numberAt2020is436() {
        let utils = MemoryGameUtils()
        var (gameState, currentTurn, lastNumber) = utils.initialGameState(from: [1, 3, 2])

        while currentTurn <= 2020 {
            utils.nextTurn(gameState: &gameState, currentTurn: &currentTurn, lastNumber: &lastNumber)
        }

        XCTAssertEqual(lastNumber, 1)
    }

    func testNextTurn_withTestInput3_numberAt2020is436() {
        let utils = MemoryGameUtils()
        var gameState = [2: 1, 1: 2]
        var currentTurn = 4
        var lastNumber = 3

        while currentTurn <= 2020 {
            utils.nextTurn(gameState: &gameState, currentTurn: &currentTurn, lastNumber: &lastNumber)
        }

        XCTAssertEqual(lastNumber, 10)
    }

    func testNextTurn_withTestInput4_numberAt2020is436() {
        let utils = MemoryGameUtils()
        var (gameState, currentTurn, lastNumber) = utils.initialGameState(from: [1, 2, 3])

        while currentTurn <= 2020 {
            utils.nextTurn(gameState: &gameState, currentTurn: &currentTurn, lastNumber: &lastNumber)
        }

        XCTAssertEqual(lastNumber, 27)
    }

    func testNextTurn_withTestInput5_numberAt2020is436() {
        let utils = MemoryGameUtils()
        var (gameState, currentTurn, lastNumber) = utils.initialGameState(from: [2, 3, 1])

        while currentTurn <= 2020 {
            utils.nextTurn(gameState: &gameState, currentTurn: &currentTurn, lastNumber: &lastNumber)
        }

        XCTAssertEqual(lastNumber, 78)
    }

    func testNextTurn_withTestInput6_numberAt2020is436() {
        let utils = MemoryGameUtils()
        var (gameState, currentTurn, lastNumber) = utils.initialGameState(from: [3, 2, 1])

        while currentTurn <= 2020 {
            utils.nextTurn(gameState: &gameState, currentTurn: &currentTurn, lastNumber: &lastNumber)
        }

        XCTAssertEqual(lastNumber, 438)
    }

    func testNextTurn_withTestInput7_numberAt2020is436() {
        let utils = MemoryGameUtils()
        var (gameState, currentTurn, lastNumber) = utils.initialGameState(from: [3, 1, 2])

        while currentTurn <= 2020 {
            utils.nextTurn(gameState: &gameState, currentTurn: &currentTurn, lastNumber: &lastNumber)
        }

        XCTAssertEqual(lastNumber, 1836)
    }

    func testInitialGameState_withTestInput2_createsGameState() {
        let utils = MemoryGameUtils()
        let (gameState, currentTurn, lastNumber) = utils.initialGameState(from: [1, 3, 2])

        XCTAssertEqual(gameState, [1: 1, 3: 2])
        XCTAssertEqual(currentTurn, 4)
        XCTAssertEqual(lastNumber, 2)
    }
}
