//
//  ContentView.swift
//  WorkcareTimer
//
//  Created by Elian Richard on 17/05/24.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    @State var isOnboardingDone = false
    @State var selection = MenuItems.home
    
    var body: some View {
        if (isOnboardingDone) {
            switch selection {
            case .home:
                HomeView(selection: $selection)
            case .achievement:
                AchievementView(selection: $selection)
            case .statistic:
                StatisticView(selection: $selection)
            case .setting:
                SettingView(selection: $selection)
            }
        } else {
            OnboardingView(isOnboardingDone: $isOnboardingDone)
        }
    }
}

#Preview {
    ContentView()
        .frame(maxWidth: 800, maxHeight: 500)
}
