//
// Created by CoffeeIT
//
// MIT License
//
// Copyright (c) 2022 CoffeeIT
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
