//
//  CITBottomSheetExampleApp.swift
//  CITBottomSheetExample
//
//  Created by CoffeeIT on 15/08/2022.
//  MIT License see LICENSE.md
//

import CITBottomSheet
import SwiftUI

@main
struct CITBottomSheetExampleApp: App {
    @StateObject private var bottomSheetManager = CITBottomSheetManager()

    var body: some Scene {
        WindowGroup {
            CITBottomSheetExampleView()
                .environmentObject(bottomSheetManager)
        }
    }
}
