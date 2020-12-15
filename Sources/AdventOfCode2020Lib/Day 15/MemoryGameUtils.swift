//
//  MemoryGameUtils.swift
//  
//
//  Created by Juan on 15/12/20.
//

import Foundation

public struct MemoryGameUtils {
    public init() {}
    public func load(from file: String) -> [Int] {
        return file
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: ",")
            .compactMap { Int($0) }
    }

    public func initialGameState(from numbers: [Int]) -> ([Int: Int], Int, Int) {
        var numbers = numbers
        let nextNumber = numbers.popLast()!
        var gameState = [Int: Int]()
        for (index, number) in numbers.enumerated() {
            gameState[number] = index + 1
        }

        return (gameState, numbers.count + 2, nextNumber)
    }

    public func nextTurn(gameState: inout [Int: Int], currentTurn: inout Int, lastNumber: inout Int) {
        var nextNumber = 0

        if let turn = gameState[lastNumber] {
            nextNumber = (currentTurn - 1) - turn
        }

        gameState[lastNumber] = currentTurn - 1
        currentTurn += 1
        lastNumber = nextNumber
    }
}
