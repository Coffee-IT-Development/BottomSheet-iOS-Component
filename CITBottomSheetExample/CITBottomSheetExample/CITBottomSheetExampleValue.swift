//
//  CITBottomSheetExampleValues.swift
//  CITBottomSheetExample
//
//  Created by Lex Brouwers on 26/09/2022.
//

import CITBottomSheet
import SwiftUI

enum CITBottomSheetExampleValue: String, CaseIterable, Identifiable {
    case withGrabber
    case withGrabberAndExpandable
    case withCloseButton
    case withSquareCornersOrangeAndAutoHeight
    case customOverlay
    case small
    case floating
    case normal
    
    var id: String {
        rawValue
    }
    
    var defaultFixedHeight: CITBottomSheetConfig.Height {
        .fixed(height: 300)
    }
    
    var defaultWidth: CITBottomSheetConfig.Width {
        .default
    }
    
    var defaultSmallWidth: CITBottomSheetConfig.Width {
        .fixed(width: UIScreen.main.bounds.width - 40)
    }
    
    var config: CITBottomSheetConfig {
        switch self {
        case .withGrabber:
            return CITBottomSheetConfig(
                backgroundColor: backgroundColor,
                height: defaultFixedHeight,
                width: defaultWidth,
                cornerStyle: .roundedTopCorners,
                accessory: .grabber,
                overlayStyle: .default
            )
        case .withGrabberAndExpandable:
            return CITBottomSheetConfig(
                backgroundColor: backgroundColor,
                height: defaultFixedHeight,
                width: defaultWidth,
                isExpandable: true,
                cornerStyle: .roundedTopCorners,
                accessory: .grabber,
                overlayStyle: .default
            )
        case .withCloseButton:
            return CITBottomSheetConfig(
                backgroundColor: backgroundColor,
                height: defaultFixedHeight,
                width: defaultWidth,
                isDraggable: false,
                cornerStyle: .roundedTopCorners,
                accessory: .closeButton(backgroundStyle: .dark),
                overlayStyle: .default
            )
        case .withSquareCornersOrangeAndAutoHeight:
            return CITBottomSheetConfig(
                backgroundColor: .orange,
                height: .auto,
                width: defaultWidth,
                cornerStyle: .square,
                accessory: .grabber,
                overlayStyle: .default
            )
        case .customOverlay:
            return CITBottomSheetConfig(
                backgroundColor: backgroundColor,
                height: defaultFixedHeight,
                width: defaultWidth,
                cornerStyle: .roundedTopCorners,
                accessory: .grabber,
                overlayStyle: .custom(color: .red, opacity: 0.33)
            )
        case .small:
            return CITBottomSheetConfig(
                backgroundColor: backgroundColor,
                height: defaultFixedHeight,
                width: defaultSmallWidth,
                cornerStyle: .roundedTopCorners,
                overlayStyle: .default
            )
        case .floating:
            return CITBottomSheetConfig(
                backgroundColor: backgroundColor,
                height: defaultFixedHeight,
                width: defaultSmallWidth,
                cornerStyle: .roundedAllCorners,
                accessory: .grabber,
                overlayStyle: .default,
                bottomPadding: 40
            )
        case .normal:
            return CITBottomSheetConfig(
                backgroundColor: backgroundColor,
                height: defaultFixedHeight,
                cornerStyle: .roundedTopCorners
            )
        }
    }
    
    var title: String {
        switch self {
        case .withGrabber:
            return "Open BottomSheet with Grabber"
        case .withGrabberAndExpandable:
            return "Open BottomSheet with Grabber and Expandable"
        case .withCloseButton:
            return "Open BottomSheet with Close Button"
        case .withSquareCornersOrangeAndAutoHeight:
            return "Open BottomSheet with Squared corners, orange background, and auto height"
        case .customOverlay:
            return "Open BottomSheet with custom overlay"
        case .small:
            return "Open BottomSheet (small)"
        case .floating:
            return "Open BottomSheet floating"
        case .normal:
            return "Open BottomSheet normal"
        }
    }
    
    var backgroundColor: Color {
        Color("bottomSheetBackgroundColor")
    }
}
