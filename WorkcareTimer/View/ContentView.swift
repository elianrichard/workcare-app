//
//  ContentView.swift
//  WorkcareTimer
//
//  Created by Elian Richard on 17/05/24.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    @StateObject var timerViewModel = TimerViewModel()
    @StateObject var questViewModel = QuestViewModel()
    @State public var isOnboardingDone = false
    @State public var selection = MenuItems.home
    
    var body: some View {
        if (isOnboardingDone) {
            switch selection {
            case .home:
                HomeView(timerViewModel: timerViewModel, questViewModel: questViewModel, selection: $selection)
            case .achievement:
                AchievementView(selection: $selection)
            case .statistic:
                StatisticView(selection: $selection)
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
