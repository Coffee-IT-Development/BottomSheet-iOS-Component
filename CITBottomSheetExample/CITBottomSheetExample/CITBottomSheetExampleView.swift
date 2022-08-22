//
//  ContentView.swift
//  CITBottomSheetExample
//
//  Created by CoffeeIT on 15/08/2022.
//  MIT License see LICENSE.md
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
