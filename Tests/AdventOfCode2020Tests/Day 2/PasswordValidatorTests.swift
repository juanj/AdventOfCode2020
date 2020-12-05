import XCTest
@testable import AdventOfCode2020Lib

final class PasswordValidatorTests: XCTestCase {
    func testParse_withSingleDigitRange_isParsedCorrectly() {
        let validator = PasswordValidator()

        let result = validator.parse("1-9 a aaaaaaaaab")

        XCTAssertEqual(result.0.range, 1...9)
    }

    func testParse_withMultiDigitRange_isParsedCorrectly() {
        let validator = PasswordValidator()

        let result = validator.parse("100-325 a aaaaaaaaab")

        XCTAssertEqual(result.0.range, 100...325)
    }

    func testParse_character_decodesCharacter() {
        let validator = PasswordValidator()

        let result = validator.parse("100-325 a aaaaaaaaab")

        XCTAssertEqual(result.0.character, "a")
    }

    func testParse_Text_decodesText() {
        let validator = PasswordValidator()

        let result = validator.parse("100-325 a aaaaaaaaab")

        XCTAssertEqual(result.1, "aaaaaaaaab")
    }

    func testValidateOldJob_withNumberOfCharactersWithinLimit_isTrue() {
        let validator = PasswordValidator()
        let password = "aaaaaaaaab"
        let policy = PasswordPolicy(position1: 1, position2: 9, character: "a")

        let result = validator.validateOldJob(password: password, with: policy)

        XCTAssertTrue(result)
    }

    func testValidateOldJob_withNumberOfCharactersBeyondLimit_isFalse() {
        let validator = PasswordValidator()
        let password = "aaaaaaaaaa"
        let policy = PasswordPolicy(position1: 1, position2: 9, character: "a")

        let result = validator.validateOldJob(password: password, with: policy)

        XCTAssertFalse(result)
    }

    func testValidateToboggan_withFirstCharacterAtPosition_isTrue() {
        let validator = PasswordValidator()
        let password =  "abbbbbbbb"
        let policy = PasswordPolicy(position1: 1, position2: 9, character: "a")

        let result = validator.validateToboggan(password: password, with: policy)

        XCTAssertTrue(result)
    }

    func testValidateToboggan_withSecondCharacterAtPosition_isTrue() {
        let validator = PasswordValidator()
        let password = "bbbbbbbba"
        let policy = PasswordPolicy(position1: 1, position2: 9, character: "a")

        let result = validator.validateToboggan(password: password, with: policy)

        XCTAssertTrue(result)
    }

    func testValidateToboggan_withBothCharactersAtPosition_isFalse() {
        let validator = PasswordValidator()
        let password = "abbbbbbba"
        let policy = PasswordPolicy(position1: 1, position2: 9, character: "a")

        let result = validator.validateToboggan(password: password, with: policy)

        XCTAssertFalse(result)
    }
}
