//
//  Day22Executer.swift
//  
//
//  Created by Juan on 22/12/20.
//

import Foundation

public struct Day22Executer: Executer {
    public init() {}
    public func execute(with input: String) {
        let utils = CardUtils()
        var decks = utils.load(from: input)

        while decks.player1.count > 0 && decks.player2.count > 0 {
            decks = utils.oneRound(decks: decks)
        }
        let deck = decks.player1.count > 0 ? decks.player1 : decks.player2
        print("The score after plaing Combat is \(utils.score(deck: deck))")

        let recursiveDeck = utils.load(from: input)
        let gameState = CardUtils.GameState(player1: recursiveDeck.player1, player2: recursiveDeck.player2)
        let winner = utils.playUntilWin(decks: gameState)
        print("The score after plaing Combat is \(utils.score(deck: winner.deck))")
    }
}
