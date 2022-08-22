//
//  CITBottomSheetView.swift
//  CITBottomSheet
//
//  This view is a modified version based on the following examples:
//
//  https://www.mozzafiller.com/posts/swiftui-slide-over-card-like-maps-stocks
//  http://chrisguirguis.com/intermediatetutorialfiles/
//
//  Created by CoffeeIT on 12/04/2022.
//  MIT License see LICENSE.md
//

import SwiftUI

public struct CITBottomSheetView<Content: View>: View {
    public enum DragState {
        case inactive
        case dragging(translation: CGSize)

        var translation: CGSize {
            switch self {
            case .inactive:
                return .zero
            case .dragging(let translation):
                return translation
            }
        }

        var isDragging: Bool {
            switch self {
            case .inactive:
                return false
            case .dragging:
                return true
            }
        }
    }

    @GestureState private var dragState = DragState.inactive
    @Binding private var isPresented: Bool
    @State private var sheetHeight: CGFloat = .zero
    @State private var initialSheetHeight: CGFloat = .zero

    private var config: CITBottomSheetConfig
    private var content: () -> Content

    private let shadowRadius: CGFloat = 5
    private let stiffness: CGFloat = 300
    private let damping: CGFloat = 30
    private let initialVelocity: CGFloat = 10
    private let maxHeightPercentage: CGFloat = 0.85

    private var modalWidth: CGFloat {
        switch config.width {
        case .`default`:
            return .infinity
        case .fixed(let width):
            return width
        }
    }

    private var cornerRadius: CGFloat {
        switch config.cornerStyle {
        case .roundedTopCorners, .roundedAllCorners:
            return DefaultValue.cornerRadius
        case .roundedTopCornersCustom(let radius), .roundedAllCornersCustom(let radius):
            return radius
        case .square:
            return .zero
        }
    }

    private var cornerRadiusCorners: UIRectCorner {
        switch config.cornerStyle {
        case .roundedTopCorners, .roundedTopCornersCustom:
            return [.topLeft, .topRight]
        case .roundedAllCorners, .roundedAllCornersCustom:
            return [.allCorners]
        case .square:
            return [.allCorners]
        }
    }

    @ViewBuilder private var headerView: some View {
        switch config.accessory {
        case .grabber:
            Grabber()
        case .closeButton(backgroundStyle: let backgroundStyle):
            CloseButton(backgroundStyle: backgroundStyle, action: close)
        case .none:
            EmptyView()
        }
    }

    public var body: some View {
        let drag = DragGesture()
            .updating($dragState) { drag, state, _ in
                if config.isDraggable {
                    state = .dragging(translation: drag.translation)
                }
            }
            .onEnded(onDragEnded)

        Group {
            VStack {
                Spacer()
                ZStack(alignment: .top) {
                    config.backgroundColor.opacity(1.0)
                        .frame(minWidth: .zero, maxWidth: modalWidth, minHeight: .zero, maxHeight: $sheetHeight.wrappedValue)
                        .cornerRadius(cornerRadius, corners: cornerRadiusCorners)
                        .shadow(radius: shadowRadius)

                    self.content()
                        .measureSize { size in
                            switch config.height {
                            case .auto:
                                sheetHeight = size.height + Constants.thirtyTwo
                            case .fixed(let height):
                                sheetHeight = height
                            }
                        }
                        .frame(minWidth: .zero, maxWidth: modalWidth, minHeight: .zero, maxHeight: $sheetHeight.wrappedValue)
                        .cornerRadius(cornerRadius, corners: cornerRadiusCorners)
                        .clipped()

                    headerView
                        .frame(minWidth: .zero, maxWidth: .infinity)
                }
                .padding(.bottom, config.bottomPadding)
                .offset(
                    y: isPresented ? (
                        (self.dragState.isDragging && dragState.translation.height >= 1) ? dragState.translation.height : .zero
                    ) : sheetHeight
                )
                .animation(isPresented ? .interpolatingSpring(stiffness: stiffness, damping: damping, initialVelocity: initialVelocity) : nil)
                .gesture(drag)
            }
            .edgesIgnoringSafeArea(.all)
        }
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
            initialSheetHeight = sheetHeight
            sheetHeight = UIScreen.main.bounds.height * maxHeightPercentage
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

    private func close() {
        isPresented = false
    }
}
