//
//  CupGameUtils.swift
//  
//
//  Created by Juan on 23/12/20.
//

import Foundation

public struct CupGameUtils {
    public init() {}
    public func load(from file: String) -> [Int] {
        file.trimmingCharacters(in: .whitespacesAndNewlines)
            .compactMap { Int(String($0)) }
    }

    public func move(cups: [Int]) -> [Int] {
        var cups = cups
        let removedCups = [cups.remove(at: 1), cups.remove(at: 1), cups.remove(at: 1)]
        var destination = cups[0] - 1
        while !cups.contains(destination) {
            destination -= 1
            if destination <= 0 {
                destination = 9
            }
        }
        guard let destinationIndex = cups.firstIndex(of: destination) else { return [] }
        cups.insert(contentsOf: removedCups, at: destinationIndex + 1)
        cups += [cups.removeFirst()]

        return cups
    }
}
