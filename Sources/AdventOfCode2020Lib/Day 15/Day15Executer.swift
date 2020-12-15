//
//  Day15Executer.swift
//  
//
//  Created by Juan on 15/12/20.
//

import Foundation

public struct Day15Executer: Executer {
    public init () {}
    public func execute(with input: String) {
        let utils = MemoryGameUtils()
        let startNumbers = utils.load(from: input)
        var (gameState, currentTurn, lastNumber) = utils.initialGameState(from: startNumbers)

        while currentTurn <= 2020 {
            utils.nextTurn(gameState: &gameState, currentTurn: &currentTurn, lastNumber: &lastNumber)
        }
        print("The 2020th number spoken is \(lastNumber)")

        var (longGameState, longCurrentTurn, longLastNumber) = utils.initialGameState(from: startNumbers)

        while longCurrentTurn <= 30_000_000 {
            utils.nextTurn(gameState: &longGameState, currentTurn: &longCurrentTurn, lastNumber: &longLastNumber)
        }
        print("The 30000000th number spoken is \(longLastNumber)")
    }
}
