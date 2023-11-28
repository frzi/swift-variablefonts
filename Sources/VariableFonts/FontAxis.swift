//
//  VariableFonts
//  Created by Freek (github.com/frzi) 2023
//

import CoreText

// MARK: - Font Axis struct
/// Description of a single font axis.
public struct FontAxis: Identifiable, Hashable, Equatable {
	public let id: UInt32
	public let name: String
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
		self.name = idToName(id)
		self.description = description
		self.minimumValue = minimum
		self.maximumValue = maximum
		self.defaultValue = `default`
	}
}
