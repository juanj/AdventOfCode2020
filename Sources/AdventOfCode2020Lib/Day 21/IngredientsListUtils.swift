//
//  IngredientsListUtils.swift
//  
//
//  Created by Juan on 21/12/20.
//

import Foundation

public struct IngredientsListUtils {
    public init() {}
    public func load(from file: String) -> [(ingredients: Set<String>, allergens: [String])] {
        file.trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
            .map { line -> (Set<String>, [String]) in
                let components = line.components(separatedBy: " (contains ")
                let words = Set(components[0].components(separatedBy: " "))
                let allergens = components[1]
                    .replacingOccurrences(of: ")", with: "")
                    .replacingOccurrences(of: ", ", with: ",")
                    .split(separator: ",")
                    .map { String($0) }
                return (words, allergens)
            }
    }

    public func getAllergens(lists: [(ingredients: Set<String>, allergens: [String])]) -> [(name: String, translatedName: String)] {
        var possible = [String: Set<String>]()
        let fullAllergens = lists.reduce(Set<String>(), { $0.union($1.allergens) })
        var temp: Set<String>?
        for allergen in fullAllergens {
            for list in lists where list.allergens.contains(allergen) {
                if temp != nil {
                    temp = temp?.intersection(list.ingredients)
                } else {
                    temp = Set(list.ingredients)
                }
            }
            if let temp = temp {
                possible[allergen] = temp
            }
            temp = nil
        }

        var sureIngredients = [(name: String, translatedName: String)]()
        searchLoop: while possible.count > 0 {
            for ingredient in possible where ingredient.value.count == 1 {
                for otherIngredient in possible where otherIngredient.key != ingredient.key && otherIngredient.value.contains(ingredient.value.first!) {
                    possible[otherIngredient.key]?.remove(ingredient.value.first!)
                }
                sureIngredients.append((name: ingredient.value.first!, translatedName: ingredient.key))
                possible.removeValue(forKey: ingredient.key)
                continue searchLoop
            }
        }

        return sureIngredients
    }

    public func getSafeIngredients(lists: [(ingredients: Set<String>, allergens: [String])], allergens: [(name: String, translatedName: String)]) -> Set<String> {
        let allergens = Set(allergens.map { $0.name })
        let fullIngredients = Set(lists.reduce([], { $0 + $1.ingredients }))
        return fullIngredients.subtracting(allergens)
    }
}
