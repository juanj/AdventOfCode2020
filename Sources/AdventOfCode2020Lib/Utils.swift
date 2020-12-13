//
//  File.swift
//  
//
//  Created by Juan on 13/12/20.
//

import Foundation

func gcd(_ a: Int, _ b: Int) -> Int {
    var (a, b) = (a, b)
    while b != 0 {
        (a, b) = (b, a % b)
    }
    return abs(a)
}

func lcm(_ a: Int, _ b: Int) -> Int {
    return (a / gcd(a, b)) * b
}
