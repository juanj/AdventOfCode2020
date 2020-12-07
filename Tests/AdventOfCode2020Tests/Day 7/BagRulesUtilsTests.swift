import XCTest
@testable import AdventOfCode2020Lib

final class BagRulesUtilsTests: XCTestCase {
    func testParseRule_withOneSubColor_parsesRule() {
        let rule = "light red bags contain 1 bright white bag, 2 muted yellow bags."
        let utils = BagRulesUtils()

        let bags = utils.parse(rule: rule)

        XCTAssertEqual(bags.color, "lightred")
        XCTAssertEqual(bags.contents, [BagContent(count: 1, color: "brightwhite"), BagContent(count: 2, color: "mutedyellow")])
    }

    func testParseRule_withNoSubColors_parsesRule() {
        let rule = "faded blue bags contain no other bags."
        let utils = BagRulesUtils()

        let bags = utils.parse(rule: rule)

        XCTAssertEqual(bags.color, "fadedblue")
        XCTAssertEqual(bags.contents, [])
    }

    func testParseFile_withMultipleSubColors_parsesAllColorNames() {
        let file = """
        light red bags contain 1 bright white bag, 2 muted yellow bags.
        dark orange bags contain 3 bright white bags, 4 muted yellow bags.
        bright white bags contain 1 shiny gold bag.
        muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
        shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
        dark olive bags contain 3 faded blue bags, 4 dotted black bags.
        vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
        faded blue bags contain no other bags.
        dotted black bags contain no other bags.
        """
        let utils = BagRulesUtils()

        let bags = utils.parse(file: file)

        XCTAssertEqual(Set(bags.keys), ["lightred", "darkorange", "brightwhite", "mutedyellow", "shinygold", "darkolive", "vibrantplum", "fadedblue", "dottedblack"])
    }

    func testIsInside_oneLevelDeep_returnsTrue() {
        let file = """
        light red bags contain 1 bright white bag, 2 muted yellow bags.
        dark orange bags contain 3 bright white bags, 4 muted yellow bags.
        bright white bags contain 1 shiny gold bag.
        muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
        shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
        dark olive bags contain 3 faded blue bags, 4 dotted black bags.
        vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
        faded blue bags contain no other bags.
        dotted black bags contain no other bags.
        """
        let utils = BagRulesUtils()

        let bags = utils.parse(file: file)

        XCTAssertTrue(utils.isInside(rules: bags, containerColor: "brightwhite", innerColor: "shinygold"))
        XCTAssertTrue(utils.isInside(rules: bags, containerColor: "brightwhite", innerColor: "shinygold"))
    }

    func testIsInside_withEmptyBag_returnsFalse() {
        let file = """
        light red bags contain 1 bright white bag, 2 muted yellow bags.
        dark orange bags contain 3 bright white bags, 4 muted yellow bags.
        bright white bags contain 1 shiny gold bag.
        muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
        shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
        dark olive bags contain 3 faded blue bags, 4 dotted black bags.
        vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
        faded blue bags contain no other bags.
        dotted black bags contain no other bags.
        """
        let utils = BagRulesUtils()

        let bags = utils.parse(file: file)

        XCTAssertFalse(utils.isInside(rules: bags, containerColor: "fadedblue", innerColor: "shinygold"))
        XCTAssertFalse(utils.isInside(rules: bags, containerColor: "dottedblack", innerColor: "shinygold"))
    }

    func testIsInside_withNotParentBag_returnsFalse() {
        let file = """
        light red bags contain 1 bright white bag, 2 muted yellow bags.
        dark orange bags contain 3 bright white bags, 4 muted yellow bags.
        bright white bags contain 1 shiny gold bag.
        muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
        shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
        dark olive bags contain 3 faded blue bags, 4 dotted black bags.
        vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
        faded blue bags contain no other bags.
        dotted black bags contain no other bags.
        """
        let utils = BagRulesUtils()

        let bags = utils.parse(file: file)

        XCTAssertFalse(utils.isInside(rules: bags, containerColor: "vibrantplum", innerColor: "shinygold"))
    }


    func testIsInside_twoLevelsDeep_returnsTrue() {
        let file = """
        light red bags contain 1 bright white bag, 2 muted yellow bags.
        dark orange bags contain 3 bright white bags, 4 muted yellow bags.
        bright white bags contain 1 shiny gold bag.
        muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
        shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
        dark olive bags contain 3 faded blue bags, 4 dotted black bags.
        vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
        faded blue bags contain no other bags.
        dotted black bags contain no other bags.
        """
        let utils = BagRulesUtils()

        let bags = utils.parse(file: file)

        XCTAssertTrue(utils.isInside(rules: bags, containerColor: "darkorange", innerColor: "shinygold"))
        XCTAssertTrue(utils.isInside(rules: bags, containerColor: "lightred", innerColor: "shinygold"))
    }

    func testNumberOfBags_withTestInput_returns32() {
        let file = """
        light red bags contain 1 bright white bag, 2 muted yellow bags.
        dark orange bags contain 3 bright white bags, 4 muted yellow bags.
        bright white bags contain 1 shiny gold bag.
        muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
        shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
        dark olive bags contain 3 faded blue bags, 4 dotted black bags.
        vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
        faded blue bags contain no other bags.
        dotted black bags contain no other bags.
        """
        let utils = BagRulesUtils()
        let bags = utils.parse(file: file)

        let numberOfBags = utils.numberOfBags(rules: bags, bagColor: "shinygold")

        XCTAssertEqual(numberOfBags - 1, 32)
    }

    func testNumberOfBags_withTestInput_returns126() {
        let file = """
        shiny gold bags contain 2 dark red bags.
        dark red bags contain 2 dark orange bags.
        dark orange bags contain 2 dark yellow bags.
        dark yellow bags contain 2 dark green bags.
        dark green bags contain 2 dark blue bags.
        dark blue bags contain 2 dark violet bags.
        dark violet bags contain no other bags.
        """
        let utils = BagRulesUtils()
        let bags = utils.parse(file: file)

        let numberOfBags = utils.numberOfBags(rules: bags, bagColor: "shinygold")

        XCTAssertEqual(numberOfBags - 1, 126)
    }
}
