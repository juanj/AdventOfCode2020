//
//  HotelCardUtils.swift
//  
//
//  Created by Juan on 25/12/20.
//

import Foundation

public struct HotelCardUtils {
    public init() {}
    public func load(from file: String) -> (cardPublicKey: Int, doorPublicKey: Int) {
        let numbers = file.trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
            .compactMap { Int($0) }
        return (numbers[0], numbers[1])
    }

    public func findCardLoopSize(publicKey: Int) -> Int {
        let subjectNumber = 7
        var guess = 1
        var loopSize = 0
        while guess != publicKey {
            loopSize += 1
            guess *= subjectNumber
            guess = guess % 20201227
        }
        return loopSize
    }

    public func encryptedKey(cardLoopSize: Int, doorPublicKey: Int) -> Int {
        let subjectNumber = doorPublicKey
        var value = 1
        for _ in 0..<cardLoopSize {
            value *= subjectNumber
            value = value % 20201227
        }
        return value
    }
}
