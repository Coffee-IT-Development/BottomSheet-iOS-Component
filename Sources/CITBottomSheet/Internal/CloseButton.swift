//
// Created by Coffee IT
//
// MIT License
//
// Copyright (c) 2022 Coffee IT
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
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
