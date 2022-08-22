//
//  CITBottomSheetManager.swift
//  CITBottomSheet
//
//  Created by CoffeeIT on 12/04/2022.
//  MIT License see LICENSE.md
//

import SwiftUI

public class CITBottomSheetManager: ObservableObject {
    public struct Sheet {
        public var content: AnyView
    }

    @Published public var sheet: Sheet?

    public lazy var isPresenting = Binding<Bool>(
        get: { self.sheet != nil },
        set: { if !$0 { self.sheet = nil } }
    )

    public func present<Content: View>(@ViewBuilder content: () -> Content) {
        sheet = Sheet(content: AnyView(content()))
    }

    public init() { }
}
