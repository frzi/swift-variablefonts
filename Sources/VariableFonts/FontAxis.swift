//
//  VariableFonts
//  Created by Freek (github.com/frzi) 2023
//

import CoreText

// MARK: - Font Axis struct
/// Description of a single font axis.
public struct FontAxis: Identifiable, Hashable, Equatable {
	public let id: UInt32
	public let name: Name
	public let description: String

	public let minimumValue: CGFloat
	public let maximumValue: CGFloat
	public let defaultValue: CGFloat

	init?(values: [String : Any]) {
		guard
			let id = values["NSCTVariationAxisIdentifier"] as? UInt32,
			let description = values["NSCTVariationAxisName"] as? String,
			let minimum = values["NSCTVariationAxisMinimumValue"] as? CGFloat,
			let maximum = values["NSCTVariationAxisMaximumValue"] as? CGFloat,
			let `default` = values["NSCTVariationAxisDefaultValue"] as? CGFloat
		else {
			return nil
		}

		self.id = id
		self.name = Name(rawValue: idToName(id))
		self.description = description
		self.minimumValue = minimum
		self.maximumValue = maximum
		self.defaultValue = `default`
	}

	/// An axis name.
	///
	/// The enum comes with a set of well known axis names (i.e `.weight` for `"wdth"`) for convenience.
	/// Use string literals to refer to a custom axis name.
	/// ```swift
	/// let weightAxis: FontAxis.Name = .weight
	/// let xtraAxis: FontAxis.Name = "XTRA"
	/// ```
	public enum Name: CustomStringConvertible, ExpressibleByStringLiteral, Hashable {
		case italic
		case opticalSize
		case slant
		case weight
		case width
		case custom(String)

		public init(rawValue: String) {
			self = switch rawValue {
			case "ital": .italic
			case "opsz": .opticalSize
			case "slnt": .slant
			case "wght": .weight
			case "wdth": .width
			default: .custom(rawValue)
			}
		}

		public init(stringLiteral value: String) {
			self.init(rawValue: value)
		}

		public var description: String {
			switch self {
			case .italic: "ital"
			case .opticalSize: "opsz"
			case .slant: "slnt"
			case .weight: "wght"
			case .width: "wdth"
			case .custom(let name): name
			}
		}
	}
}
