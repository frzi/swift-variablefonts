//
//  VariableFonts
//  Created by Freek (github.com/frzi) 2023
//

#if os(macOS)
import AppKit

typealias PlatformFont = NSFont
typealias PlatformFontDescriptor = NSFontDescriptor
#elseif os(iOS) || os(tvOS) || os(watchOS)
import UIKit

typealias PlatformFont = UIFont
typealias PlatformFontDescriptor = UIFontDescriptor
#endif

import CoreText

// MARK: - UI/NSFont extension
public extension PlatformFont {
	private static func descriptorFor(name: String, axes: [UInt32 : CGFloat]) -> PlatformFontDescriptor {
		PlatformFontDescriptor(fontAttributes: [
			.name: name,
			kCTFontVariationAttribute as PlatformFontDescriptor.AttributeName: axes,
		])
	}

	/// Initialize a font with the given axes.
	convenience init?(name: String, size: CGFloat, axes: [String : CGFloat]) {
		let axes = Dictionary(uniqueKeysWithValues: axes.map { key, value in
			return (nameToId(key), value)
		})

		let descriptor = Self.descriptorFor(name: name, axes: axes)
		self.init(descriptor: descriptor, size: size)
	}

	/// Get all available axes information of the font.
	func allAxes() -> [FontAxis] {
		let ctFont = CTFontCreateWithName(fontName as CFString, fontDescriptor.pointSize, nil)
		guard let axes = CTFontCopyVariationAxes(ctFont) as? [[String : Any]] else {
			return []
		}

		return axes.compactMap(FontAxis.init(values:))
	}

	// MARK: - Set axis.
	func withAxis(_ axis: UInt32, value: CGFloat) -> Self {
		let descriptor = Self.descriptorFor(name: fontName, axes: [
			axis: value
		])
		return Self.init(descriptor: descriptor, size: pointSize)!
	}

	func withAxis(_ axis: String, value: CGFloat) -> Self {
		let axis = nameToId(axis)
		let descriptor = Self.descriptorFor(name: fontName, axes: [
			axis: value
		])
		return Self.init(descriptor: descriptor, size: pointSize)!
	}

	func withAxes(_ axes: [UInt32 : CGFloat]) -> Self {
		let descriptor = Self.descriptorFor(name: fontName, axes: axes)
		return Self.init(descriptor: descriptor, size: pointSize)!
	}

	func withAxes(_ axes: [String : CGFloat]) -> Self {
		let axes: [UInt32 : CGFloat] = Dictionary(uniqueKeysWithValues: axes.map { key, value in
			return (nameToId(key), value)
		})
		let descriptor = Self.descriptorFor(name: fontName, axes: axes)
		return Self.init(descriptor: descriptor, size: pointSize)!
	}
}

#if canImport(SwiftUI)

import SwiftUI

// MARK: - SwiftUI Font extension
public extension Font {
	static func custom(name: String, size: CGFloat, axes: [String : CGFloat]) -> Font {
		guard let font = PlatformFont(name: name, size: size, axes: axes) else {
			return .system(size: size)
		}

		return Font(font)
	}
}

#endif
