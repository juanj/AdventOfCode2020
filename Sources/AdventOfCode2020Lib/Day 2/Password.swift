//
//  File.swift
//  
//
//  Created by Juan on 2/12/20.
//

import Foundation

public struct Password: Equatable {
    let text: String
    let range: ClosedRange<Int>
    let character: Character
}
