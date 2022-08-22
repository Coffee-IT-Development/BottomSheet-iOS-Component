//
//  Grabber.swift
//  CITBottomSheet
//
//  Created by CoffeeIT on 12/04/2022.
//  MIT License see LICENSE.md
//

import SwiftUI

struct Grabber: View {
    static let grabberHeight: CGFloat = 5
    static let grabberWidth: CGFloat = 54
    static let contentHeight = grabberHeight + Constants.fortyEight

    var body: some View {
        RoundedRectangle(cornerRadius: Constants.eight)
            .fill(Color.gray)
            .frame(width: Self.grabberWidth, height: Self.grabberHeight, alignment: .center)
            .padding(.top, Constants.sixteen)
            .padding(.bottom, Constants.thirtyTwo)
    }
}
