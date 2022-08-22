//
//  PressedButtonStyle.swift
//  CITBottomSheet
//
//  Created by CoffeeIT on 12/04/2022.
//  MIT License see LICENSE.md
//

import SwiftUI

struct PressedButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .opacity(configuration.isPressed ? 0.8 : 1.0)
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
    }
}
