//
//  Cup.swift
//  
//
//  Created by Juan on 23/12/20.
//

import Foundation

public class Cup {
    let label: Int
    var next: Cup?
    var previous: Cup?

    public init(label: Int, next: Cup? = nil, previous: Cup? = nil) {
        self.label = label
        self.next = next
        self.previous = previous
    }
}
