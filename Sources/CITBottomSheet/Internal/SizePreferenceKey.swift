//
//  SizePreferenceKey.swift
//  CITBottomSheet
//
//  Created by CoffeeIT on 12/04/2022.
//  MIT License see LICENSE.md
//

import SwiftUI

struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero

    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

