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

public struct CITBottomSheetModifier<SheetContent: View>: ViewModifier {
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    @Binding private var isPresented: Bool
    private let onDimiss: CITBottomSheetAction?
    private let sheetContent: () -> SheetContent
    private let config: CITBottomSheetConfig

    private var overlayColor: Color {
        switch config.overlayStyle {
        case .`default`:
            return Color.black.opacity(DefaultValue.opacity)
        case .custom(let color, let opacity):
            return color.opacity(opacity)
        case .none:
            return .clear
        }
    }

    public func body(content: Content) -> some View {
        ZStack(alignment: .bottom) {
            content
            
            overlayColor
                .ignoresSafeArea()
                .opacity(isPresented ? 1 : 0)
                .animation(.easeInOut(duration: 0.3))
                .onTapGesture {
                    withAnimation {
                        isPresented.toggle()
                    }
                }
            
            CITBottomSheetView(isPresented: $isPresented, config: config) {
                sheetContent()
            }
            .animation(.easeInOut(duration: 0.3))
            .transition(.move(edge: .bottom))
        }
        .onChange(of: isPresented) { newValue in
            if !newValue {
                onDimiss?()
            }
        }
    }

    public init(
        isPresented: Binding<Bool>,
        config: CITBottomSheetConfig,
        onDismiss: CITBottomSheetAction?,
        sheetContent: @escaping () -> SheetContent
    ) {
        self._isPresented = isPresented
        self.config = config
        self.onDimiss = onDismiss
        self.sheetContent = sheetContent
    }
}

public extension View {
    func bottomSheet<Content: View>(
        isPresented: Binding<Bool>,
        config: CITBottomSheetConfig,
        onDimiss: CITBottomSheetAction? = nil,
        @ViewBuilder sheetContent: @escaping () -> Content
    ) -> some View {
        modifier(
            CITBottomSheetModifier(
                isPresented: isPresented,
                config: config,
                onDismiss: onDimiss,
                sheetContent: sheetContent
            )
        )
    }
}
