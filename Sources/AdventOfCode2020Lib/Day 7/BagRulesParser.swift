//
//  BagRulesParser.swift
//  
//
//  Created by Juan on 7/12/20.
//

import Foundation

public struct BagRulesUtils {
    public func parse(file: String) -> [String: BagsRule] {
        let rules = file.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: "\n")

        var all = [String: BagsRule]()
        for rule in rules.map({ parse(rule: $0) }) {
            all[rule.color] = rule
        }

        return all
    }

    public func parse(rule: String) -> BagsRule {
        guard !rule.contains(" bags contain no other bags.") else {
            let color = rule
                .components(separatedBy: " bags contain no other bags.")
                .first?
                .replacingOccurrences(of: " ", with: "")
                ?? ""
            return BagsRule(color: color, contents: [])
        }

        let components = rule.components(separatedBy: " bags contain ")
        let mainColor = components[0].replacingOccurrences(of: " ", with: "")
        var content = [BagContent]()

        for color in components[1].components(separatedBy: ", ") {
            let components = color.components(separatedBy: " ")
            content.append(.init(count: Int(components[0]) ?? 0, color: components[1] + components[2]))
        }

        return BagsRule(color: mainColor, contents: content)
    }

    public func isInside(rules: [String: BagsRule], containerColor: String, innerColor: String) -> Bool {
        guard let rule = rules[containerColor] else { return false }
        if rule.contents.contains(where: { $0.color == innerColor }) {
            return true
        }

        for color in rule.contents.map(\.color) {
            if isInside(rules: rules, containerColor: color, innerColor: innerColor) {
                return true
            }
        }


        return false
    }

    public func numberOfBags(rules: [String: BagsRule], bagColor: String) -> Int {
        guard let bag = rules[bagColor] else { return 0 }
        if bag.contents.count > 0 {
            return bag.contents.map { $0.count * numberOfBags(rules: rules, bagColor: $0.color) }
                .reduce(1, +)
        }
        return 1
    }
}
