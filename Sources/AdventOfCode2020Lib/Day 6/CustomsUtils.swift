//
//  CustomsUtils.swift
//  
//
//  Created by Juan on 6/12/20.
//

import Foundation

public struct CustomsUtils {
    public func loadAnswers(from file: String) -> [[Set<Character>]] {
        file.replacingOccurrences(of: "\n\n", with: "|")
            .split(separator: "|")
            .map {
                $0.split(separator: "\n")
                    .map { Set($0) }
            }
    }

    public func uniqueAnswers(groups: [[Set<Character>]]) -> [Set<Character>] {
        groups.map {
            $0.reduce(Set<Character>(), {
                $0.union($1)
            })
        }
    }

    public func commonAnswers(groups: [[Set<Character>]]) -> [Set<Character>] {
        groups.map {
            $0.reduce(Set("abcdefghijklmnopqrstuvwxyz"), {
                $0.intersection($1)
            })
        }
    }
}
