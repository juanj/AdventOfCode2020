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

        print("The score after plaing Combat is \(utils.score(decks: decks))")
    }
}
