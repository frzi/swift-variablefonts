//
//  VariableFonts
//  Created by Freek (github.com/frzi) 2023
//

#if os(macOS)
import AppKit

typealias PlatformFont = NSFont
typealias PlatformFontDescriptor = NSFontDescriptor
#elseif os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)
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

	/// Initialize a font with the given axes using identifiers.
	///
	/// This initializer expects a dictionary with axis identifiers (`UInt32`) as key.
	/// ```swift
	///	let axes: [UInt32 : CGFloat] = [
	///		2003072104: 400, // Weight
	///		2003072104: 200, // Width
	///	]
	/// ```
	convenience init?(name: String, size: CGFloat, axes: [UInt32 : CGFloat]) {
		let descriptor = Self.descriptorFor(name: name, axes: axes)
		self.init(descriptor: descriptor, size: size)
	}

	/// Initialize a font with the given axes using names.
	///
	/// This initializer expects a dictionary with axis names (`String`) as key.
	/// ```swift
	///	let axes: [String : CGFloat] = [
	///		"wght": 400, // Weight
	///		"wdth": 200, // Width
	///	]
	/// ```
	convenience init?(name: String, size: CGFloat, axes: [String : CGFloat]) {
		let axes = Dictionary(uniqueKeysWithValues: axes.map { key, value in
			return (nameToId(key), value)
		})
		self.init(name: name, size: size, axes: axes)
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
	/// Returns a new font with the applied axis, using the identifier as key.
	func withAxis(_ id: UInt32, value: CGFloat) -> Self {
		let descriptor = Self.descriptorFor(name: fontName, axes: [
			id: value
		])
		#if os(macOS)
		return Self.init(descriptor: descriptor, size: pointSize)!
		#else
		return Self.init(descriptor: descriptor, size: pointSize)
		#endif
	}

	/// Returns a new font with the applied axis, using the name as key.
	func withAxis(_ name: String, value: CGFloat) -> Self {
		let id = nameToId(name)
		let descriptor = Self.descriptorFor(name: fontName, axes: [
			id: value
		])
		#if os(macOS)
		return Self.init(descriptor: descriptor, size: pointSize)!
		#else
		return Self.init(descriptor: descriptor, size: pointSize)
		#endif
	}

	/// Returns a new font with the applied axex, using the identifier as key.
	func withAxes(_ axes: [UInt32 : CGFloat]) -> Self {
		let descriptor = Self.descriptorFor(name: fontName, axes: axes)
		#if os(macOS)
		return Self.init(descriptor: descriptor, size: pointSize)!
		#else
		return Self.init(descriptor: descriptor, size: pointSize)
		#endif
	}

	/// Returns a new font with the applied axex, using the name as key.
	func withAxes(_ axes: [String : CGFloat]) -> Self {
		let axes: [UInt32 : CGFloat] = Dictionary(uniqueKeysWithValues: axes.map { key, value in
			return (nameToId(key), value)
		})
		let descriptor = Self.descriptorFor(name: fontName, axes: axes)
		#if os(macOS)
		return Self.init(descriptor: descriptor, size: pointSize)!
		#else
		return Self.init(descriptor: descriptor, size: pointSize)
		#endif
	}
}

#if canImport(SwiftUI)

import SwiftUI

// MARK: - SwiftUI Font extension
public extension Font {
	/// Create a custom font with the given name,size that scales with the body text style and variable font axes.
	///
	/// ```swift
	///	Text("Hello world")
	///		.font(.custom(
	///			name: "Amstelvar",
	///			size: 20,
	///			axes: ["opsz": 100]
	///		))
	/// ```
	static func custom(name: String, size: CGFloat, axes: [String : CGFloat]) -> Font {
		guard let font = PlatformFont(name: name, size: size, axes: axes) else {
			return .system(size: size)
		}

		return Font(font)
	}
}

#endif
