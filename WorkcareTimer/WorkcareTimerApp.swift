//
//  WorkcareTimerApp.swift
//  WorkcareTimer
//
//  Created by Elian Richard on 17/05/24.
//

import SwiftUI

@main
struct WorkcareTimerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(minWidth: 800, idealWidth: 800, maxWidth: .infinity, minHeight: 500, idealHeight: 500, maxHeight: .infinity)
                .environment(CloudQuestViewModel())
                .environment(CloudFlowViewModel())
        }
        .windowStyle(.hiddenTitleBar)
    }
}
