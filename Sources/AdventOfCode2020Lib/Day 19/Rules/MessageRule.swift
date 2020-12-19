//
//  MessageRule.swift
//  
//
//  Created by Juan on 19/12/20.
//

import Foundation

public protocol MessageRule {
    func match(_ string: String) -> String
}
