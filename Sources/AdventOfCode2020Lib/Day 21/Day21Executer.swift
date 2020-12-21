//
//  Day21Executer.swift
//  
//
//  Created by Juan on 21/12/20.
//

import Foundation

public struct Day21Executer: Executer {
    public init() {}
    public func execute(with input: String) {
        let utils = IngredientsListUtils()
        let lists = utils.load(from: input)

        let allergens = utils.getAllergens(lists: lists)
        let safeIngredients = utils.getSafeIngredients(lists: lists, allergens: allergens)
        let count = lists.reduce(0) { result, list -> Int in
            return result + list.ingredients.reduce(0, { $0 + (safeIngredients.contains($1) ? 1 : 0) })
        }
        print("The number of times safe ingredients apper is: \(count)")
        print("The canonical dangerous ingredient list is: \(allergens.sorted { $0.translatedName < $1.translatedName }.map(\.name).joined(separator: ","))")
    }
}
