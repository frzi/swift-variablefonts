//
//  VariableFonts
//  Created by Freek (github.com/frzi) 2023
//

package func idToName(_ id: UInt32) -> String {
	var str = ""
	for a in (0 ..< 4).reversed() {
		if let scalar = UnicodeScalar((id >> (a * 8)) & 0xFF) {
			str += String(Character(scalar))
		}
	}
	return str
}

package func nameToId(_ name: String) -> UInt32 {
	name.compactMap { $0.asciiValue }
		.reduce(UInt32(0)) { $0 << 8 | UInt32($1) }
}
