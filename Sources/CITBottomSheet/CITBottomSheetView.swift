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

import SwiftUI

public struct CITBottomSheetView<Content: View>: View {
    @GestureState private var dragState = DragState.inactive
    @Binding private var isPresented: Bool
    @State private var sheetHeight: CGFloat = 0
    @State private var initialSheetHeight: CGFloat = 0
    
    private var config: CITBottomSheetConfig
    private var content: () -> Content

    private let shadowRadius: CGFloat = 5
    private let stiffness: CGFloat = 300
    private let damping: CGFloat = 30
    private let initialVelocity: CGFloat = 10
    private let maxHeightPercentage: CGFloat = 0.85
    
    var maxHeight: CGFloat {
        UIScreen.main.bounds.height * maxHeightPercentage
    }
    
    var expandedBackgroundHeight: CGFloat {
        config.isExpandable ? UIScreen.main.bounds.height : 0
    }
    
    var isDraggingDown: Bool {
        dragState.isDragging && dragState.translation.height > 0
    }
    
    var isExpandableButNotExpanded: Bool {
        config.isExpandable && sheetHeight != maxHeight
    }
    
    var clampedOffset: CGFloat {
        isDraggingDown ? dragState.translation.height : max(dragState.translation.height, -maxHeight + sheetHeight)
    }
    
    public init(
        isPresented: Binding<Bool>,
        config: CITBottomSheetConfig,
        content: @escaping () -> Content
    ) {
        self._isPresented = isPresented
        self.config = config
        self.content = content
    }
    
    public var body: some View {
        VStack {
            Spacer()
            
            ZStack(alignment: .top) {
                config.backgroundColor.opacity(1.0)
                    .frame(
                        minWidth: .zero,
                        maxWidth: config.modalWidth,
                        minHeight: .zero,
                        maxHeight: $sheetHeight.wrappedValue + expandedBackgroundHeight
                    )
                    .cornerRadius(config.cornerRadius, corners: config.cornerRadiusCorners)
                    .shadow(radius: shadowRadius)
                
                content()
                    .background(GeometryReader { geometry in
                        Color.clear
                            .onAppear {
                                updateSheetHeight(with: geometry.size.height)
                            }
                            .onChange(of: geometry.size) { size in
                                updateSheetHeight(with: size.height)
                            }
                    })
                    .frame(minWidth: .zero, maxWidth: config.modalWidth, minHeight: .zero, maxHeight: $sheetHeight.wrappedValue)
                    .cornerRadius(config.cornerRadius, corners: config.cornerRadiusCorners)
                    .clipped()

                headerView
                    .frame(minWidth: .zero, maxWidth: .infinity)
            }
            .padding(.bottom, isPresented ? config.bottomPadding : 0)
            .offset(
                y: isPresented ? (
                    (isDraggingDown || isExpandableButNotExpanded) ? clampedOffset : .zero
                ) : sheetHeight
            )
            .animation(.interpolatingSpring(stiffness: stiffness, damping: damping, initialVelocity: initialVelocity))
            .gesture(dragGesture)
            .padding(.bottom, -expandedBackgroundHeight)
        }
        .edgesIgnoringSafeArea(.all)
    }

    @ViewBuilder
    private var headerView: some View {
        switch config.accessory {
        case .grabber:
            Grabber()
        case .closeButton(backgroundStyle: let backgroundStyle):
            CloseButton(backgroundStyle: backgroundStyle, action: close)
        case .none:
            EmptyView()
        }
    }
    
    private var dragGesture: some Gesture {
        DragGesture()
            .updating($dragState) { drag, state, _ in
                if config.isDraggable {
                    state = .dragging(translation: drag.translation)
                }
            }
            .onEnded(onDragEnded)
    }
    
    private func onDragEnded(drag: DragGesture.Value) {
        guard config.isDraggable else {
            return
        }

        let dragThreshold = sheetHeight * (2 / 3)

        guard config.isExpandable else {
            if drag.predictedEndTranslation.height > dragThreshold || drag.translation.height > dragThreshold {
                close()
            }

            return
        }

        if (drag.location.y - drag.startLocation.y) < 0 {
            sheetHeight = maxHeight
        } else {
            sheetHeight = initialSheetHeight

            if drag.predictedEndTranslation.height > dragThreshold || drag.translation.height > dragThreshold {
                close()
            }
        }
    }

    private func fractionProgress(lowerLimit: Double, upperLimit: Double, current: Double, inverted: Bool = false) -> Double {
        var val: Double = 0
        if current >= upperLimit {
            val = 1
        } else if current <= lowerLimit {
            val = 0
        } else {
            val = (current - lowerLimit) / (upperLimit - lowerLimit)
        }

        if inverted {
            return (1 - val)
        } else {
            return val
        }
    }
    
    private func updateSheetHeight(with geometryHeight: CGFloat) {
        switch config.height {
        case .auto:
            sheetHeight = geometryHeight + Constants.thirtyTwo
            initialSheetHeight = sheetHeight
        case .fixed(let height):
            sheetHeight = height
            initialSheetHeight = sheetHeight
        }
    }

    private func close() {
        isPresented = false
    }
}
