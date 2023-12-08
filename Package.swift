// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "VariableFonts",
	platforms: [
		.macOS(.v10_15),
		.iOS(.v13),
		.tvOS(.v13),
		.watchOS(.v6),
		.macCatalyst(.v13),
		.visionOS(.v1)
	],
	products: [
		.library(
			name: "VariableFonts",
			targets: ["VariableFonts"]),
	],
	dependencies: [],
	targets: [
		.target(
			name: "VariableFonts"),
		.testTarget(
			name: "VariableFontsTests",
			dependencies: ["VariableFonts"]),
	]
)
