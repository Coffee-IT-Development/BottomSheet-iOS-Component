//
//  CITBottomSheetConfig.swift
//  CITBottomSheet
//
//  Created by CoffeeIT on 12/04/2022.
//  MIT License see LICENSE.md
//

import SwiftUI

public struct CITBottomSheetConfig {
    public enum Height {
        case auto
        case fixed(height: CGFloat)
    }

    public enum Width {
        case `default`
        case fixed(width: CGFloat)
    }

    public enum CloseButtonBackgroundStyle {
        case dark
        case light
    }

    public enum Accessory {
        case grabber
        case closeButton(backgroundStyle: CloseButtonBackgroundStyle)
    }

    public enum CornerStyle {
        case roundedTopCorners
        case roundedTopCornersCustom(radius: CGFloat)
        case roundedAllCorners
        case roundedAllCornersCustom(radius: CGFloat)
        case square
    }

    public enum OverlayStyle {
        case `default`
        case custom(color: Color, opacity: CGFloat)
    }

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

    public init(
        backgroundColor: Color,
        height: Height,
        width: Width = .default,
        isExpandable: Bool = false,
        isDraggable: Bool = true,
        cornerStyle: CornerStyle,
        accessory: Accessory? = nil,
        overlayStyle: OverlayStyle? = .default,
        bottomPadding: CGFloat = .zero
    ) {
        self.backgroundColor = backgroundColor
        self.height = height
        self.width = width
        self.isExpandable = isExpandable
        self.isDraggable = isDraggable
        self.cornerStyle = cornerStyle
        self.accessory = accessory
        self.overlayStyle = overlayStyle
        self.bottomPadding = bottomPadding
    }
}
