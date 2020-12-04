import XCTest
@testable import AdventOfCode2020Lib

final class CredentialTests: XCTestCase {
    func testInit_fromString_initsObject() {
        let input = """
        ecl:gry pid:860033327 eyr:2020 hcl:#fffffd
        byr:1937 iyr:2017 cid:147 hgt:183cm
        """

        let credential = Credential(from: input)

        XCTAssertEqual(credential, Credential(birthYear: 1937, issueYear: 2017, expirationYear: 2020, hairColor: "#fffffd", height: "183cm", eyeColor: "gry", passportId: "860033327", countryId: "147"))
    }

    func testIsValid_withAllFields_returnsTrue() {
        let credential = Credential(birthYear: 2000, issueYear: 2012, expirationYear: 2020, hairColor: "#ffffff", height: "170cm", eyeColor: "amb", passportId: "000333999", countryId: "123")

        XCTAssertTrue(credential.isValid())
    }

    func testIsValid_withEmptyCid_returnsTrue() {
        let credential = Credential(birthYear: 2000, issueYear: 2012, expirationYear: 2020, hairColor: "#ffffff", height: "170cm", eyeColor: "amb", passportId: "000333999", countryId: nil)

        XCTAssertTrue(credential.isValid())
    }

    func testIsValid_withEmptyPid_returnsFalse() {
        let credential = Credential(birthYear: 2000, issueYear: 2012, expirationYear: 2020, hairColor: "#ffffff", height: "170cm", eyeColor: "amb", passportId: nil, countryId: "123")

        XCTAssertFalse(credential.isValid())
    }

    func testIsValid_withEmptyRequiredFields_returnsFalse() {
        let credential = Credential(birthYear: nil, issueYear: nil, expirationYear: nil, hairColor: nil, height: nil, eyeColor: nil, passportId: nil, countryId: "")

        XCTAssertFalse(credential.isValid())
    }
}
