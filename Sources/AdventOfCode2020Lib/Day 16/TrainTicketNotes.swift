//
//  TrainTicketNotes.swift
//  
//
//  Created by Juan on 16/12/20.
//

import Foundation

public struct TrainTicketNotes {
    public struct Field: Equatable, Hashable {
        let name: String
        let rules: [ClosedRange<Int>]

        init(from string: String) {
            let components = string.components(separatedBy: ": ")
            name = components[0]

            var rules = [ClosedRange<Int>]()
            for range in components[1].components(separatedBy: " or ") {
                let numbers = range
                    .components(separatedBy: "-")
                    .compactMap { Int($0) }
                rules.append(numbers[0]...numbers[1])
            }
            self.rules = rules
        }

        init(name: String, rules: [ClosedRange<Int>]) {
            self.name = name
            self.rules = rules
        }
    }

    var fields: [Field]
    var yourTicket: [Int]
    var nearbyTickets: [[Int]]
}
