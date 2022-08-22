//
//  View+Styling.swift
//  CITBottomSheet
//
//  Created by CoffeeIT on 12/04/2022.
//  MIT License see LICENSE.md
//

import SwiftUI

extension View {
    func cornerRadius(_ cornerRadius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(cornerRadius: cornerRadius, corners: corners) )
    }
}
