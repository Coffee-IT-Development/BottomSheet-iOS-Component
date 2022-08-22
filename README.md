[![Coffee IT - iOS Aroma BottomSheet Component]({link_to_header_image})](https://coffeeit.nl/)

[![Swift Package Manager](https://img.shields.io/badge/Swift_Package_Manager-Compatible-brightgreen?style=flat-square)](https://img.shields.io/badge/Swift_Package_Manager-Compatible-brightgreen?style=flat-square)
[![Swift {swift_version}](https://img.shields.io/badge/Swift-5.6-brightgreen?style=flat-square)](https://img.shields.io/badge/Swift-5.6-brightgreen?style=flat-square)
[![iOS {ios_version}](https://img.shields.io/badge/iOS-v13+-brightgreen?style=flat-square)](https://img.shields.io/badge/iOS-v13+-brightgreen?style=flat-square)
[![Mirror Repository](https://img.shields.io/badge/Mirror-Repository-brightgreen?style=flat-square)](https://img.shields.io/badge/Mirror-Repository-brightgreen?style=flat-square)
[![License](https://img.shields.io/badge/License-MIT-brightgreen.svg?style=flat-square)](LICENSE.md)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-CoffeeIT-blue.svg?style=flat-square)](https://linkedin.com/company/coffee-it)
[![Facebook](https://img.shields.io/badge/Facebook-CoffeeITNL-blue.svg?style=flat-square)](https://www.facebook.com/CoffeeITNL/)
[![Instagram](https://img.shields.io/badge/Instagram-CoffeeITNL-blue.svg?style=flat-square)](https://www.instagram.com/coffeeitnl/)
[![Twitter](https://img.shields.io/badge/Twitter-CoffeeITNL-blue.svg?style=flat-square)](https://twitter.com/coffeeitnl)

# BottomSheet

A customisable BottomSheet that can be used from iOS 13 and up. Also has an Android counterpart and a figma design to complete the circle.

This GitHub repository is a mirror, the official repository is hosted privately by Coffee IT.

Created by [Coffee IT](https://coffeeit.nl/).

<img src="https://i.imgur.com/eWTuU2m.gif" width="300">


# ⚡ Installation
This component requires minimum __iOS 13__.

## SwiftPM
To install the Swift Package, go to Project > Package Dependencies > + > Search or Enter Package URL > Fill in:
```
https://github.com/Coffee-IT-Development/BottomSheet-iOS-Component
```


# 📖 Usage

Root

```swift
import CITBottomSheet
import SwiftUI

@main
struct CITBottomSheetExampleApp: App {
    @StateObject private var bottomSheetManager = CITBottomSheetManager()

    var body: some Scene {
        WindowGroup {
            CITBottomSheetExampleView()
                .environmentObject(bottomSheetManager)
        }
    }
}
```


View

```swift 
import CITBottomSheet
import SwiftUI

struct CITBottomSheetExampleView: View {
    @EnvironmentObject private var bottomSheetManager: CITBottomSheetManager
    
    private var config = CITBottomSheetConfig(
        backgroundColor: Color.white,
        height: .fixed(height: 300),
        cornerStyle: .roundedTopCorners
    )
    
    var body: some View {
        Button("Open Bottom Sheet") {
            bottomSheetManager.present() {
                VStack {
                    Text("Item 1")
                    Text("Item 2")
                    Text("Item 3")
                    Text("Item 4")
                    Text("Item 5")
                    Text("Item 6")
                }
            }
        }
        .bottomSheet(isPresented: bottomSheetManager.isPresenting, config: config, onDimiss: nil) {
            bottomSheetManager.sheet?.content
        }
    }

}
```


## ⚙️ Customisation

```swift
/// Set background color
/// The app is responsible for setting the right background color for dark mode support
/// Required
/// No default value
let backgroundColor: Color

/// Heigth options:
/// - `auto` the bottom sheets calculates the height based on the view in it
/// - `fixed` the app sets the height
/// Required
/// No default value
let height: Height

/// Width options:
/// - `default` is full width of the view
/// - `fixed` the app sets the width
/// Optional
/// Default value: `default`
let width: Width

/// If set to true the bottom sheet is draggable to the top to expand the sheet
/// Optional
/// Default value = `false`
let isExpandable: Bool

/// If set to false the user cannot drag the sheet down to close it
/// Optional
/// Default value = `true`
let isDraggable: Bool

/// CornerStyle options:
/// - `roundedTopCorners` (only top corners, has default corner radius of 16)
/// - `roundedTopCornersCustom` (only top corners, set your own corner radius)
/// - `roundedAllCorners` (all corners, has default corner radius of 16)
/// - `roundedAllCornersCustom` (all corners, set your own corner radius)
/// - `square` (no corner radius)
/// Required
/// No default value
let cornerStyle: CornerStyle

/// Accessory options:
/// - `grabber`
/// - `closeButton` (which you need to give a `backgroundStyle` either `.dark` or `.light`)
/// Optional
/// Default value = `nil`
let accessory: Accessory?

/// OverlayStyle options:
/// - `default` black (60% opacity) overlay
/// - `custom` set your own overlay by specifying `color` and `opacity`
/// Optional
/// Default value = `default`
/// Could be set to `nil` for no overlay
let overlayStyle: OverlayStyle?

/// You set the `bottomPadding` to create a floating bottom sheet.
/// Optional
/// Default value = `.zero`
let bottomPadding: CGFloat
```

# 🔗 Related publications

- [BottomSheet for Android]({link_to_android_repo})
- [BottomSheet Figma design]({link_to_figma})

Look at our other repositories on our [GitHub account](https://github.com/orgs/Coffee-IT-Development/repositories).

# ✏️ Changelog
[Changelog](CHANGELOG.md)

# 📧 Contact
Do you have questions, ideas or need help? Send us an email at contact@coffeeit.nl.

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="https://global-uploads.webflow.com/605a171ee93af49275331843/623b23cdea80a92703e61b42_Logo_black_1.svg" width="100">
  <source media="(prefers-color-scheme: light)" srcset="https://coffeeit.nl/wp-content/uploads/2016/09/logo_dark_small_new.png" width="100">
  <img alt="CoffeeIT logo" src="https://coffeeit.nl/wp-content/uploads/2016/09/logo_dark_small_new.png">
</picture>

# ⚠️ License
The BottomSheet package is licensed under the terms of the [MIT Open Source license](LICENSE.md).
