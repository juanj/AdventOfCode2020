//
//  TrainTicketUtils.swift
//  
//
//  Created by Juan on 16/12/20.
//

import Foundation

public struct TrainTicketUtils {
    public func load(from file: String) -> TrainTicketNotes {
        let sections = file
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: "\n\n")

        let fields = sections[0]
            .components(separatedBy: "\n")
            .map { TrainTicketNotes.Field(from: $0) }

        let yourTicket = sections[1]
            .components(separatedBy: "\n")[1]
            .components(separatedBy: ",")
            .compactMap { Int($0) }

        let nearbyTockets = sections[2]
            .components(separatedBy: "\n")
            .dropFirst()
            .map {
                $0.components(separatedBy: ",")
                    .compactMap { Int($0) }
            }

        return TrainTicketNotes(fields: fields, yourTicket: yourTicket, nearbyTickets: nearbyTockets)
    }

    public func invalidNumbers(notes: TrainTicketNotes) -> [Int] {
        var invalid = [Int]()
        for ticket in notes.nearbyTickets {
            valueLoop: for fieldValue in ticket {
                for field in notes.fields {
                    if field.rules[0].contains(fieldValue) || field.rules[1].contains(fieldValue) {
                        continue valueLoop
                    }
                }
                invalid.append(fieldValue)
            }
        }
        return invalid
    }

    private func isValid(ticket: [Int], fields: [TrainTicketNotes.Field]) -> Bool {
        for value in ticket {
            var valid = false
            for field in fields {
                if field.rules[0].contains(value) || field.rules[1].contains(value) {
                    valid = true
                }
            }

            if !valid {
                return false
            }
        }
        return true
    }

    public func validTickets(notes: TrainTicketNotes) -> [[Int]] {
        var valid = [[Int]]()
        for ticket in notes.nearbyTickets {
            if isValid(ticket: ticket, fields: notes.fields) {
                valid.append(ticket)
            }
        }
        return valid
    }

    public func orderFields(notes: TrainTicketNotes) -> [TrainTicketNotes.Field] {
        let tickets = validTickets(notes: notes) + [notes.yourTicket]

        var ticketsPossibleFields = Array(repeating: Array(repeating: Set<TrainTicketNotes.Field>(), count: notes.fields.count), count: tickets.count)
        for (ticketIndex, ticket) in tickets.enumerated() {
            for(fieldIndex, fieldValue) in ticket.enumerated() {
                for field in notes.fields {
                    if field.rules[0].contains(fieldValue) || field.rules[1].contains(fieldValue) {
                        ticketsPossibleFields[ticketIndex][fieldIndex].insert(field)
                    }
                }
            }
        }

        var validFields = Array(repeating: Set<TrainTicketNotes.Field>(), count: notes.fields.count)
        for field in 0..<notes.fields.count {
            let fields = ticketsPossibleFields.reduce(Set(notes.fields), { $0.intersection($1[field]) })
            validFields[field] = fields
        }

        var toRemove = [TrainTicketNotes.Field]()
        while true {
            if validFields.reduce(0, { $0 + $1.count }) == validFields.count {
                break
            }

            for (index, fields) in validFields.enumerated() {
                if fields.count == 1 {
                    toRemove.append(contentsOf: fields)
                } else {
                    for item in toRemove {
                        validFields[index].remove(item)
                    }
                }
            }
        }
        return validFields.compactMap { $0.first }
    }
}
