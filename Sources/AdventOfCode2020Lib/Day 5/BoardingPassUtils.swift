//
//  BoardingPassUtils.swift
//  
//
//  Created by Juan on 5/12/20.
//

import Foundation

public struct BoardingPassUtils {
    public init() {}
    public func loadList(from file: String) -> [BoardingPass] {
        let list = file.split(separator: "\n")
        return list.map { BoardingPass(from: String($0)) }
    }

    public func max(boardingPasses: [BoardingPass]) -> Int {
        return boardingPasses.map(\.id).max() ?? 0
    }

    public func findMissing(boardingPasses: [BoardingPass]) -> Int {
        let ids = boardingPasses.map(\.id).sorted()

        var last = ids[0]
        for id in ids.dropFirst() {
            if id != last + 1 {
                return last + 1
            }
            last = id
        }
        return -1
    }
}
