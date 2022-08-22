//
//  CloseButton.swift
//  CITBottomSheet
//
//  Created by CoffeeIT on 12/04/2022.
//  MIT License see LICENSE.md
//

import SwiftUI

// TODO: Use SystemIconButton when Xcode 14 / Swift 5.7 is available
struct CloseButton: View {
    private let size: CGFloat = 32
    private let iconSize: CGFloat = 40
    private let iconColor: Color = .white

    private let backgroundStyle: CITBottomSheetConfig.CloseButtonBackgroundStyle
    private let action: () -> Void

    @ViewBuilder
    private var backgroundView: some View {
        switch backgroundStyle {
        case .dark:
            VisualEffectView(effect: UIBlurEffect(style: .dark))
                .frame(width: size, height: size)
                .clipShape(Circle())
        case .light:
            VisualEffectView(effect: UIBlurEffect(style: .light))
                .frame(width: size, height: size)
                .clipShape(Circle())
        }
    }

    var body: some View {
        HStack {
            Spacer()

            Button(action: self.action) {
                ZStack {
                    backgroundView

                    Image(systemName: "xmark")
                        .font(Font.body.weight(.bold))
                        .foregroundColor(iconColor)
                        .imageScale(.small)
                        .frame(width: iconSize, height: iconSize)
                }
            }
            .buttonStyle(PressedButtonStyle())
        }
        .padding(Constants.sixteen)
    }

    init(
        backgroundStyle: CITBottomSheetConfig.CloseButtonBackgroundStyle,
        action: @escaping () -> Void
    ) {
        self.backgroundStyle = backgroundStyle
        self.action = action
    }
}
