//
//  MonsterMessageUtils.swift
//  
//
//  Created by Juan on 19/12/20.
//

import Foundation

public struct MonsterMessageUtils {
    public init() {}
    public func load(from file: String) -> ([String: MessageRule], [String]) {
        let components = file
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: "\n\n")

        let messages = components[1]
            .components(separatedBy: "\n")
        return (loadRules(from: components[0]), messages)
    }

    public func loadRules(from file: String) -> [String: MessageRule] {
        var rules = [String: MessageRule]()
        var prerules = file
            .components(separatedBy: "\n")
            .reduce([String: String](), { dict, component -> [String: String] in
                var dict = dict
                let components = component.components(separatedBy: ": ")
                dict[components[0]] = components[1]
                return dict
            })

        // Define concrete rules
        for (key, prerule) in prerules {
            if prerule.contains("\"") {
                rules[key] = ConcreteMessageRule(String(prerule.split(separator: "\"")[0]))
                prerules.removeValue(forKey: key)
            }
        }

        while prerules.count > 0 {
            keyloop: for (key, prerule) in prerules {
                if prerule.contains("|") {
                    let components = prerule
                        .components(separatedBy: " | ")
                        .map {
                            $0.components(separatedBy: " ")
                        }
                    var subRules = [MessageRule]()

                    for andGroup in components {
                        var andRules = [MessageRule]()
                        for ruleKey in andGroup {
                            if let rule = rules[ruleKey] {
                                andRules.append(rule)
                            } else {
                                continue keyloop
                            }
                        }
                        subRules.append(AndMessageRule(rules: andRules))
                    }

                    rules[key] = OrMessageRule(rules: subRules)
                    prerules.removeValue(forKey: key)
                } else {
                    let keys = prerule.components(separatedBy: " ")
                    var andRules = [MessageRule]()
                    for key in keys {
                        if let rule = rules[key] {
                            andRules.append(rule)
                        } else {
                            continue keyloop
                        }
                    }
                    rules[key] = AndMessageRule(rules: andRules)
                    prerules.removeValue(forKey: key)
                }
            }
        }

        return rules
    }

    public func patchRules(_ rules: [String: MessageRule]) -> [String: MessageRule] {
        var rules = rules
        let rule8 = RecusriveRule(baseCase: rules["42"]!, recursiveCase: [rules["42"]!, RecursivePlaceholder()])
        let rule11 = RecusriveRule(baseCase: AndMessageRule(rules: [rules["42"]!, rules["31"]!]), recursiveCase: [rules["42"]!, RecursivePlaceholder(), rules["31"]!])
        rules["8"] = rule8
        rules["11"] = rule11

        // Only rule 0 depend on those
        rules["0"] = InverseLookupAndRule(rule1: rule8, rule2: rule11)
        return rules
    }
}
