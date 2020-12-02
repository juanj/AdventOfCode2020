import XCTest
@testable import AdventOfCode2020Lib

final class PasswordValidatorTests: XCTestCase {
    func testParse_withSingleDigitRange_isParsedCorrectly() {
        let validator = PasswordValidator()

        let result = validator.parse("1-9 a aaaaaaaaab")

        XCTAssertEqual(result.range, 1...9)
    }

    func testParse_withMultiDigitRange_isParsedCorrectly() {
        let validator = PasswordValidator()

        let result = validator.parse("100-325 a aaaaaaaaab")

        XCTAssertEqual(result.range, 100...325)
    }

    func testParse_character_decodesCharacter() {
        let validator = PasswordValidator()

        let result = validator.parse("100-325 a aaaaaaaaab")

        XCTAssertEqual(result.character, "a")
    }

    func testParse_Text_decodesText() {
        let validator = PasswordValidator()

        let result = validator.parse("100-325 a aaaaaaaaab")

        XCTAssertEqual(result.text, "aaaaaaaaab")
    }

    func testValidateOldJob_withNumberOfCharactersWithinLimit_isTrue() {
        let validator = PasswordValidator()
        let password = Password(text: "aaaaaaaaab", position1: 1, position2: 9, character: "a")

        let result = validator.validateOldJob(password)

        XCTAssertTrue(result)
    }

    func testValidateOldJob_withNumberOfCharactersBeyondLimit_isFalse() {
        let validator = PasswordValidator()
        let password = Password(text: "aaaaaaaaaa", position1: 1, position2: 9, character: "a")

        let result = validator.validateOldJob(password)

        XCTAssertFalse(result)
    }

    func testValidateToboggan_withFirstCharacterAtPosition_isTrue() {
        let validator = PasswordValidator()
        let password = Password(text: "abbbbbbbb", position1: 1, position2: 9, character: "a")

        let result = validator.validateToboggan(password)

        XCTAssertTrue(result)
    }

    func testValidateToboggan_withSecondCharacterAtPosition_isTrue() {
        let validator = PasswordValidator()
        let password = Password(text: "bbbbbbbba", position1: 1, position2: 9, character: "a")

        let result = validator.validateToboggan(password)

        XCTAssertTrue(result)
    }

    func testValidateToboggan_withBothCharactersAtPosition_isFalse() {
        let validator = PasswordValidator()
        let password = Password(text: "abbbbbbba", position1: 1, position2: 9, character: "a")

        let result = validator.validateToboggan(password)

        XCTAssertFalse(result)
    }
}
