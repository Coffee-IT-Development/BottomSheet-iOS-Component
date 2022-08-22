//
//  RoundedCorner.swift
//  CITBottomSheet
//
//  Created by CoffeeIT on 12/04/2022.
//  MIT License see LICENSE.md
//

import SwiftUI

struct RoundedCorner: Shape {
    private let cornerRadius: CGFloat
    private let corners: UIRectCorner

    init(cornerRadius: CGFloat = .infinity, corners: UIRectCorner = .allCorners) {
        self.cornerRadius = cornerRadius
        self.corners = corners
    }

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        return Path(path.cgPath)
    }
}
