//
//  View+Keyboard.swift
//  CITBottomSheet
//
//  Created by CoffeeIT on 12/04/2022.
//  MIT License see LICENSE.md
//

import SwiftUI

extension View {
    #if canImport(UIKit)
    func endEditing() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    #endif

    /// Doesn't adjust the safe area insets when the keyboard is shown. Only works for iOS 14 or higher, otherwise it does nothing.
    @ViewBuilder
    func ignoresSafeAreaForKeyboard(_ edges: Edge.Set = .all) -> some View {
        if #available(iOS 14.0, *) {
            ignoresSafeArea(.keyboard, edges: edges)
        } else {
            self
        }
    }

    /// Ignores the safe area. Setting custom edges works for iOS 14 or higher, otherwise always all edges are ignored.
    @ViewBuilder
    func ignoresSafeArea(_ edges: Edge.Set = .all) -> some View {
        if #available(iOS 14.0, *) {
            ignoresSafeArea(.all, edges: edges)
        } else {
            edgesIgnoringSafeArea(.all)
        }
    }
}
