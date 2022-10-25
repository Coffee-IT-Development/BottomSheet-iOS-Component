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

import CITBottomSheet
import SwiftUI

struct CITBottomSheetExampleView: View {
    @State private var exampleSheet: CITBottomSheetExampleValue = .normal
    @State private var showingSheet = false
    @State private var config = CITBottomSheetConfig(
        backgroundColor: Color("bottomSheetBackgroundColor"),
        height: .fixed(height: 300),
        cornerStyle: .roundedTopCorners
    )
    
    var body: some View {
        VStack(spacing: 16) {
            Image("aroma-component-header")
                .padding(.top, 32)
                .padding(.bottom, 16)

            Text("BottomSheet")
                .font(.title)
                .padding(.bottom, 16)

            VStack(spacing: 16) {
                ForEach(CITBottomSheetExampleValue.allCases) { sheet in
                    Button {
                        show(sheet: sheet)
                    } label: {
                        Text(sheet.title)
                    }
                }
            }
            .padding(.horizontal, 16)

            Spacer()
        }
        .bottomSheet(isPresented: $showingSheet, config: config) {
            bottomSheetContent
        }
    }
    
    @ViewBuilder
    var bottomSheetContent: some View {
        switch exampleSheet {
        case .withGrabber,
             .withGrabberAndExpandable,
             .withCloseButton,
             .customOverlay,
             .small,
             .floating,
             .normal:
            exampleStack(itemCount: 6)
        case .withSquareCornersOrangeAndAutoHeight:
            exampleStack(itemCount: 10, spacing: 16, padding: 32)
        }
    }
    
    @ViewBuilder
    private func exampleStack(itemCount: Int, spacing: CGFloat = 8, padding: CGFloat = 0) -> some View {
        VStack(spacing: spacing) {
            ForEach(1 ... itemCount, id: \.self) {
                Text("Item \($0)")
            }
        }
        .padding(padding)
    }
    
    private func show(sheet: CITBottomSheetExampleValue) {
        exampleSheet = sheet
        config = sheet.config
        showingSheet = true
        // (Optional) TODO: Fix issue of switching between large auto size and smaller sheet slight visual glitch, springs from previous height instead of bottom edge.
    }
}

struct CITBottomSheetExampleView_Previews: PreviewProvider {
    static var previews: some View {
        CITBottomSheetExampleView()
    }
}
