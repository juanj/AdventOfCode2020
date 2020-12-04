//
//  Credential.swift
//  
//
//  Created by Juan on 4/12/20.
//

import Foundation

public struct Credential: Equatable {
    var birthYear: String?
    var issueYear: String?
    var expirationYear: String?
    var height: String?
    var hairColor: String?
    var eyeColor: String?
    var passportId: String?
    var countryId: String?

    public init(birthYear: String?, issueYear: String?, expirationYear: String?, hairColor: String?, height: String?, eyeColor: String?, passportId: String?, countryId: String?) {
        self.birthYear = birthYear
        self.issueYear = issueYear
        self.expirationYear = expirationYear
        self.height = height
        self.hairColor = hairColor
        self.eyeColor = eyeColor
        self.passportId = passportId
        self.countryId = countryId
    }

    public init(from string: String) {
        let fields = string.split { " \n".contains($0) }
        fields.forEach { field in
            let keyValue = field.split(separator: ":").map { String($0) }
            switch keyValue[0] {
            case "byr":
                birthYear = keyValue[1]
            case "iyr":
                issueYear = keyValue[1]
            case "eyr":
                expirationYear = keyValue[1]
            case "hgt":
                height = keyValue[1]
            case "hcl":
                hairColor = keyValue[1]
            case "ecl":
                eyeColor = keyValue[1]
            case "pid":
                passportId = keyValue[1]
            case "cid":
                countryId = keyValue[1]
            default: break
            }
        }
    }

    public func isValid() -> Bool {
        return birthYear != nil &&
            issueYear != nil &&
            expirationYear != nil &&
            height != nil &&
            hairColor != nil &&
            eyeColor != nil &&
            passportId != nil
    }
}
