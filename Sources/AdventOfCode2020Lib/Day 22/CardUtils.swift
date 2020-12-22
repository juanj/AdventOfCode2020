//
//  CardUtils.swift
//  
//
//  Created by Juan on 22/12/20.
//

import Foundation

public struct CardUtils {
    public init() {}
    public func load(from file: String) -> (player1: [Int], player2: [Int]) {
        let decks = file.trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: "\n\n")
            .map { $0
                .components(separatedBy: .newlines)
                .dropFirst()
                .map { Int($0) ?? 0 }
            }
        return (decks[0], decks[1])
    }

    public func oneRound(decks: (player1: [Int], player2: [Int])) -> (player1: [Int], player2: [Int]) {
        guard decks.player1.count > 0 && decks.player2.count > 0 else {
            return decks
        }
        var decks = decks

        let player1Card = decks.player1.removeFirst()
        let player2Card = decks.player2.removeFirst()

        if player1Card > player2Card {
            decks.player1.append(player1Card)
            decks.player1.append(player2Card)
        } else {
            decks.player2.append(player2Card)
            decks.player2.append(player1Card)
        }

        return decks
    }

    public func score(decks: (player1: [Int], player2: [Int])) -> Int {
        let deck: [Int]
        if decks.player1.count > 0 {
            deck = decks.player1
        } else {
            deck = decks.player2
        }

        return deck
            .reversed()
            .enumerated()
            .reduce(0, { $0 + ($1.element * ($1.offset + 1)) })
    }
}
