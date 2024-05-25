//
//  WorkcareTimerApp.swift
//  WorkcareTimer
//
//  Created by Elian Richard on 17/05/24.
//

import SwiftUI
import SwiftData

@main
struct WorkcareTimerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(minWidth: 800, idealWidth: 800, maxWidth: .infinity, minHeight: 500, idealHeight: 500, maxHeight: .infinity)
        }
        .windowStyle(.hiddenTitleBar)
        .modelContainer(for: [FlowModel.self, QuestModel.self])
    }
}

//class CustomWindowController: NSWindowController, NSWindowDelegate {
//    override func windowDidLoad() {
//        super.windowDidLoad()
//        guard let window = self.window else { return }
//
//        // Customize the window appearance
//        window.titleVisibility = .hidden
//        window.titlebarAppearsTransparent = true
//        window.isMovableByWindowBackground = true
//        window.styleMask.insert(.fullSizeContentView)
//        window.backgroundColor = .white
//    }
//}
