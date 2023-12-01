import XCTest
@testable import VariableFonts

final class VariableFontsTests: XCTestCase {
	func testNameToId() throws {
		let values: [String : UInt32] = [
			"wght": 2003265652,
			"wdth": 2003072104,
			"opsz": 1869640570,
			"slnt": 1936486004,
			"ital": 1769234796,
		]

		for (name, id) in values {
			XCTAssertEqual(nameToId(name), id, "Name \(name) does NOT match ID \(id).")
		}
	}

	func testIdToName() throws {
		let values: [UInt32 : String] = [
			2003265652: "wght",
			2003072104: "wdth",
			1869640570: "opsz",
			1936486004: "slnt",
			1769234796: "ital",
		]

		for (id, name) in values {
			XCTAssertEqual(idToName(id), name, "ID \(id) does NOT match name \(name).")
		}
	}
}
