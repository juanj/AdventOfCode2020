//
//  MemoryUtils.swift
//  
//
//  Created by Juan on 14/12/20.
//

import Foundation

public struct MemoryUtils {
    public init() {}
    public func load(from file: String) -> [MemoryOperation] {
        let lines = file.trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: "\n")

        var operations = [MemoryOperation]()
        var currentOperation: MemoryOperation?
        for line in lines {
            if line.hasPrefix("mask = ") {
                if let currentOperation = currentOperation {
                    operations.append(currentOperation)
                }
                currentOperation = MemoryOperation(mask: Mask(from: String(line.dropFirst(7))), assignments: [:])
            } else if line.hasPrefix("mem[") {
                let key = Int(String(line.dropFirst(4)).components(separatedBy: "]")[0]) ?? 0
                let value = UInt64(line.components(separatedBy: " ").last ?? "") ?? 0
                currentOperation?.assignments[key] = value
            }
        }
        if let currentOperation = currentOperation {
            operations.append(currentOperation)
        }

        return operations
    }
}
