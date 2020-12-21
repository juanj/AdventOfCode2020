import XCTest
@testable import AdventOfCode2020Lib

final class IngredientsListUtilsTests: XCTestCase {
    func testLoad_withTestInput_loadsIngredients() {
        let input = """
        mxmxvkd kfcds sqjhc nhms (contains dairy, fish)
        trh fvjkl sbzzf mxmxvkd (contains dairy)
        sqjhc fvjkl (contains soy)
        sqjhc mxmxvkd sbzzf (contains fish)
        """
        let utils = IngredientsListUtils()
        let ingredients = utils.load(from: input)

        XCTAssertEqual(ingredients[0].ingredients, ["mxmxvkd", "kfcds", "sqjhc", "nhms"])
        XCTAssertEqual(ingredients[1].ingredients, ["trh", "fvjkl", "sbzzf", "mxmxvkd"])
        XCTAssertEqual(ingredients[2].ingredients, ["sqjhc", "fvjkl"])
        XCTAssertEqual(ingredients[3].ingredients, ["sqjhc", "mxmxvkd", "sbzzf"])

        XCTAssertEqual(ingredients[0].allergens, ["dairy", "fish"])
        XCTAssertEqual(ingredients[1].allergens, ["dairy"])
        XCTAssertEqual(ingredients[2].allergens, ["soy"])
        XCTAssertEqual(ingredients[3].allergens, ["fish"])
    }
}
