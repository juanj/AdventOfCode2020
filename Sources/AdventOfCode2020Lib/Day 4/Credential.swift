//
//  Credential.swift
//  
//
//  Created by Juan on 4/12/20.
//

import Foundation

public struct Credential: Equatable {
    var birthYear: Int?
    var issueYear: Int?
    var expirationYear: Int?
    var height: String?
    var hairColor: String?
    var eyeColor: String?
    var passportId: String?
    var countryId: String?

    public init(birthYear: Int?, issueYear: Int?, expirationYear: Int?, hairColor: String?, height: String?, eyeColor: String?, passportId: String?, countryId: String?) {
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
                if let year = Int(keyValue[1]), year >= 1920 && year <= 2002 {
                    birthYear = year
                }
            case "iyr":
                if let year = Int(keyValue[1]), year >= 2010 && year <= 2020 {
                    issueYear = year
                }
            case "eyr":
                if let year = Int(keyValue[1]), year >= 2020 && year <= 2030 {
                    expirationYear = year
                }
            case "hgt":
                if let height = Int(keyValue[1].dropLast(2)) {
                    if keyValue[1].suffix(2) == "cm" && height >= 150 && height <= 193 {
                        self.height = keyValue[1]
                    } else if keyValue[1].suffix(2) == "in" && height >= 59 && height <= 76 {
                        self.height = keyValue[1]
                    }
                }
            case "hcl":
                if keyValue[1].prefix(1) == "#" &&
                    keyValue[1].count == 7 &&
                    keyValue[1].dropFirst().contains(where: { "0123456789abcdf".contains($0) }) {
                    hairColor = keyValue[1]
                }
            case "ecl":
                let validColors = ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]
                if validColors.contains(keyValue[1]) {
                    eyeColor = keyValue[1]
                }
            case "pid":
                if keyValue[1].count == 9 && keyValue[1].contains(where: { "0123456789".contains($0) }) {
                    passportId = keyValue[1]
                }
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
