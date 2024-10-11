# Variable Fonts

> Easier use of variable fonts with AppKit, UIKit and SwiftUI. For iOS, macOS, tvOS, watchOS and visionOS

![SwiftUI](https://img.shields.io/github/v/release/frzi/swift-variablefonts?style=for-the-badge)
[![SwiftUI](https://img.shields.io/badge/SwiftUI-blue.svg?style=for-the-badge&logo=swift&logoColor=black)](https://developer.apple.com/xcode/swiftui)
[![Swift](https://img.shields.io/badge/Swift-5.9-orange.svg?style=for-the-badge&logo=swift)](https://swift.org)
[![Xcode](https://img.shields.io/badge/Xcode-15-blue.svg?style=for-the-badge&logo=Xcode&logoColor=white)](https://developer.apple.com/xcode)
[![MIT](https://img.shields.io/badge/license-MIT-black.svg?style=for-the-badge)](https://opensource.org/licenses/MIT)

Extends AppKit's `NSFont`, UIKit's `UIFont` and SwiftUI's `Font` with variable font features. Couldn't be easier!

## How-to-use
### Initializing font with axes.
```swift
let font = NSFont(name: "Amstelvar", size: 20, axes: [
	"wght": 650,
	"opsz": 100,
	"XTRA": 700,
])
```

### New font with a single axis applied
```swift
let scienceGothic = UIFont(name: "ScienceGothic", size: 20)!
let slanted = scienceGothic.withAxis("slnt", value: -10)
```

### Get all available axes of a font
```swift
let tiltWarp = NSFont(name: "TiltWarp-Regular", size: 100)!
let axes = tiltWarp.allAxes()
print(axes)
/*
[VariableFonts.FontAxis(
	id: 1481789268,
	name: "XROT",
	description: "Rotation in X",
	minimumValue: -45.0,
	maximumValue: 45.0,
	defaultValue: 0.0),
etc...]
*/
```

### SwiftUI
```swift
Text("Hello world")
	.font(.custom(name: "Fraunces", size: 40, axes: [
		"wght": 900,
		"SOFT": 100,
		"WONK": 1,
	]))
```

### Example: maxed out font
```swift
let nunito = UIFont(name: "NunitoSans", size: 20)!
let axes = nunito.allAxes()

// Creates a UIFont with all axes set to their maximum value.
let megaNunito = nunito.withAxes(
	Dictionary(uniqueKeysWithValues: axes.map { axis in
		return (axis.id, axis.maximumValue)
	})
)
```
