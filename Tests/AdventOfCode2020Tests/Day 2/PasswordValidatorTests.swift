import XCTest
@testable import AdventOfCode2020Lib

final class PasswordValidatorTests: XCTestCase {
    func testParse_withSingleDigitRange_isParsedCorrectly() {
        let validator = PasswordValidator()

        let result = validator.parse("1-9 a aaaaaaaaab")

        XCTAssertEqual(result, Password(text: "aaaaaaaaab", range: 1...9, character: "a"))
    }

    func testParse_withMultiDigitRange_isParsedCorrectly() {
        let validator = PasswordValidator()

        let result = validator.parse("100-325 a aaaaaaaaab")

        XCTAssertEqual(result, Password(text: "aaaaaaaaab", range: 100...325, character: "a"))
    }

    func testValidate_withNumberOfCharactersWithinLimit_isTrue() {
        let validator = PasswordValidator()
        let password = Password(text: "aaaaaaaaab", range: 1...9, character: "a")

        let result = validator.validate(password)

        XCTAssertTrue(result)
    }

    func testValidate_withNumberOfCharactersBeyondLimit_isFalse() {
        let validator = PasswordValidator()
        let password = Password(text: "aaaaaaaaaa", range: 1...9, character: "a")

        let result = validator.validate(password)

        XCTAssertFalse(result)
    }
}
