import XCTest
@testable import AdventOfCode2020Lib

final class FloatingMemoryIteratorTests: XCTestCase {
    func testNext_withFloatingMask_generatesNextAddresses() {
        var iterator = FloatingMemoryIterator(mask: Mask(from: "X0X"), address: 0)

        var addresses = Set<UInt64>()
        while let address = iterator.next() {
            addresses.insert(address)
        }

        XCTAssertEqual(addresses, [0b000, 0b001, 0b100, 0b101])
    }

    func testNext_withTestInput_generates4addresses() {
        var iterator = FloatingMemoryIterator(mask: Mask(from: "000000000000000000000000000000X1001X"), address: 42)

        var addresses = Set<UInt64>()
        while let address = iterator.next() {
            addresses.insert(address)
        }

        XCTAssertEqual(Set(addresses.map { String($0, radix: 2) }), Set([0b000000000000000000000000000000011010,
                                   0b000000000000000000000000000000011011,
                                   0b000000000000000000000000000000111010,
                                   0b000000000000000000000000000000111011].map { String($0, radix: 2) }))
    }
}
