//
//  Mask.swift
//  
//
//  Created by Juan on 14/12/20.
//

import Foundation

public struct Mask: Equatable {
    let onesMask: UInt64
    let zerosMask: UInt64
    let floatingMask: UInt64
    let rawMask: String

    public init(from string: String) {
        rawMask = string
        onesMask = UInt64(string.replacingOccurrences(of: "0", with: "X")
            .replacingOccurrences(of: "X", with: "0"), radix: 2) ?? 0
        zerosMask = UInt64(string.replacingOccurrences(of: "1", with: "X")
                            .replacingOccurrences(of: "X", with: "1"), radix: 2) ?? .max
        floatingMask = UInt64(string.replacingOccurrences(of: "1", with: "0")
                            .replacingOccurrences(of: "X", with: "1"), radix: 2) ?? .max
    }

    public func apply(to memory: UInt64) -> UInt64 {
        var masked = memory | onesMask
        masked = masked & zerosMask
        return masked
    }
}
