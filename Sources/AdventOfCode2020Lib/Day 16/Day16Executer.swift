//
//  Day16Executer.swift
//  
//
//  Created by Juan on 16/12/20.
//

import Foundation

public class Day16Executer: Executer {
    public init() {}
    public func execute(with input: String) {
        let utils = TrainTicketUtils()
        let notes = utils.load(from: input)
        let invalidNumbers = utils.invalidNumbers(notes: notes)
        print("The sum of the invalid numbers is \(invalidNumbers.reduce(0, +))")

        let orderedFields = utils.orderFields(notes: notes)
        var departureFields = [Int]()
        for (index, value) in orderedFields.enumerated() where value.name.hasPrefix("departure") {
            departureFields.append(notes.yourTicket[index])
        }
        print(#"The product of the value of the fields containing departure is \#(departureFields.reduce(1, *))"#)
    }
}
