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
    @EnvironmentObject private var bottomSheetManager: CITBottomSheetManager

    private let backgroundColor = Color("bottomSheetBackgroundColor")

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

            Group {
                Button("Open BottomSheet with Grabber") {
                    config = CITBottomSheetConfig(
                        backgroundColor: backgroundColor,
                        height: .fixed(height: 300),
                        width: .default,
                        cornerStyle: .roundedTopCorners,
                        accessory: .grabber,
                        overlayStyle: .default
                    )

                    bottomSheetManager.present() {
                        makeVStackWithSixTextItems()
                    }
                }

                Button("Open BottomSheet with Grabber and Expendable") {
                    config = CITBottomSheetConfig(
                        backgroundColor: backgroundColor,
                        height: .fixed(height: 300),
                        width: .default,
                        isExpandable: true,
                        cornerStyle: .roundedTopCorners,
                        accessory: .grabber,
                        overlayStyle: .default
                    )

                    bottomSheetManager.present() {
                        makeVStackWithSixTextItems()
                    }
                }

                Button("Open BottomSheet with Close Button") {
                    config = CITBottomSheetConfig(
                        backgroundColor: backgroundColor,
                        height: .fixed(height: 300),
                        width: .default,
                        isDraggable: false,
                        cornerStyle: .roundedTopCorners,
                        accessory: .closeButton(backgroundStyle: .dark),
                        overlayStyle: .default
                    )

                    bottomSheetManager.present() {
                        makeVStackWithSixTextItems()
                    }
                }

                Button("Open BottomSheet with Squared corners, orange background, and auto height") {
                    config = CITBottomSheetConfig(
                        backgroundColor: .orange,
                        height: .auto,
                        width: .default,
                        cornerStyle: .square,
                        accessory: .grabber,
                        overlayStyle: .default
                    )

                    bottomSheetManager.present() {
                        VStack(spacing: 16) {
                            Text("Item 0")
                            Text("Item 1")
                            Text("Item 2")
                            Text("Item 3")
                            Text("Item 4")
                            Text("Item 5")
                            Text("Item 6")
                            Text("Item 7")
                            Text("Item 8")
                            Text("Item 9")
                        }
                        .padding(32)
                    }
                }

                Button("Open BottomSheet with custom overlay") {
                    config = CITBottomSheetConfig(
                        backgroundColor: backgroundColor,
                        height: .fixed(height: 300),
                        width: .default,
                        cornerStyle: .roundedTopCorners,
                        accessory: .grabber,
                        overlayStyle: .custom(color: .red, opacity: 0.33)
                    )

                    bottomSheetManager.present() {
                        makeVStackWithSixTextItems()
                    }
                }

                Button("Open BottomSheet (small)") {
                    config = CITBottomSheetConfig(
                        backgroundColor: backgroundColor,
                        height: .fixed(height: 300),
                        width: .fixed(width: UIScreen.main.bounds.width - 40),
                        cornerStyle: .roundedTopCorners,
                        overlayStyle: .default
                    )

                    bottomSheetManager.present() {
                        makeVStackWithSixTextItems()
                    }
                }

                Button("Open BottomSheet floating") {
                    config = CITBottomSheetConfig(
                        backgroundColor: backgroundColor,
                        height: .fixed(height: 300),
                        width: .fixed(width: UIScreen.main.bounds.width - 40),
                        cornerStyle: .roundedAllCorners,
                        accessory: .grabber,
                        overlayStyle: .default,
                        bottomPadding: 40
                    )

                    bottomSheetManager.present() {
                        makeVStackWithSixTextItems()
                    }
                }

                Button("Open BottomSheet") {
                    config = CITBottomSheetConfig(
                        backgroundColor: backgroundColor,
                        height: .fixed(height: 300),
                        cornerStyle: .roundedTopCorners
                    )

                    bottomSheetManager.present() {
                        makeVStackWithSixTextItems()
                    }
                }
            }
            .padding(.horizontal, 16)

            Spacer()
        }
        .bottomSheet(isPresented: bottomSheetManager.isPresenting, config: config, onDimiss: nil) {
            bottomSheetManager.sheet?.content
        }
    }

    @ViewBuilder func makeVStackWithSixTextItems() -> some View {
        VStack {
            ForEach(1...6, id: \.self) {
                Text("Item \($0)")
            }
        }
    }
}

struct CITBottomSheetExampleView_Previews: PreviewProvider {
    static var previews: some View {
        CITBottomSheetExampleView()
    }
}
