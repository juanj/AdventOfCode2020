//
//  CardUtils.swift
//  
//
//  Created by Juan on 22/12/20.
//

import Foundation

public struct CardUtils {
    public enum Player {
        case player1, player2
    }

    public struct GameState: Hashable {
        var player1: [Int]
        var player2: [Int]
    }

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

    public func playUntilWin(decks: GameState, seenStates: Set<GameState> = []) -> (winner: Player, deck: [Int]) {
        var seenStates = seenStates
        var currentState = decks
        while currentState.player1.count > 0 && currentState.player2.count > 0 {
            if seenStates.contains(currentState) {
                return (winner: .player1, deck: currentState.player1)
            }
            seenStates.insert(currentState)
            let player1Card = currentState.player1.removeFirst()
            let player2Card = currentState.player2.removeFirst()

            if currentState.player1.count >= player1Card && currentState.player2.count >= player2Card {
                let subState = GameState(player1: Array(currentState.player1.prefix(player1Card)), player2: Array(currentState.player2.prefix(player2Card)))
                if playUntilWin(decks: subState, seenStates: seenStates).winner == .player1 {
                    currentState.player1.append(player1Card)
                    currentState.player1.append(player2Card)
                } else {
                    currentState.player2.append(player2Card)
                    currentState.player2.append(player1Card)
                }
            } else {
                if player1Card > player2Card {
                    currentState.player1.append(player1Card)
                    currentState.player1.append(player2Card)
                } else {
                    currentState.player2.append(player2Card)
                    currentState.player2.append(player1Card)
                }
            }
        }

        if currentState.player1.count > 0 {
            return (winner: .player1, deck: currentState.player1)
        } else {
            return (winner: .player2, deck: currentState.player2)
        }
    }

    public func score(deck: [Int]) -> Int {
        return deck
            .reversed()
            .enumerated()
            .reduce(0, { $0 + ($1.element * ($1.offset + 1)) })
    }
}
