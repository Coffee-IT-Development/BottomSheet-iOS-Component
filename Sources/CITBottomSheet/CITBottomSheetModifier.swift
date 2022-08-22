//
//  CITBottomSheetModifier.swift
//  CITHalfModalManager
//
//  Created by CoffeeIT on 12/04/2022.
//  MIT License see LICENSE.md
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

            if isPresented {
                overlayColor
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation {
                            isPresented.toggle()
                        }
                    }

                CITBottomSheetView(isPresented: $isPresented, config: config) {
                    sheetContent()
                }
                .animation(.easeInOut(duration: 0.5))
                .transition(.move(edge: .bottom))
            }
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
