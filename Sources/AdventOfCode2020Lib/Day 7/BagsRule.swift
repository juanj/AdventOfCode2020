//
//  BagsRule.swift
//  
//
//  Created by Juan on 7/12/20.
//

import Foundation

public struct BagsRule: Equatable {
    let color: String
    let contents: [BagContent]
}

public struct BagContent: Equatable {
    let count: Int
    let color: String
}
