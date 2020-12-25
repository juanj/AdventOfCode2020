//
//  Day25Executer.swift
//  
//
//  Created by Juan on 25/12/20.
//

import Foundation

public struct Day25Executer: Executer {
    public init() {}
    public func execute(with input: String) {
        let utils = HotelCardUtils()
        let keys = utils.load(from: input)
        let cardLoopSize = utils.findCardLoopSize(publicKey: keys.cardPublicKey)
        print("The encripted key is \(utils.encryptedKey(cardLoopSize: cardLoopSize, doorPublicKey: keys.doorPublicKey))")
    }
}
