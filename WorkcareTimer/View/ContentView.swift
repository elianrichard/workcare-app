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
    @StateObject var userViewModel = UserViewModel()
    @State public var selection = MenuItems.home
    
    var body: some View {
        if (userViewModel.isLoggedIn) {
            switch selection {
            case .home:
                HomeView(timerViewModel: timerViewModel, questViewModel: questViewModel, selection: $selection)
                    .onAppear {
                        print(userViewModel.userId, userViewModel.firstName, userViewModel.email, userViewModel.lastName)
                    }
            case .achievement:
                AchievementView(timerViewModel: timerViewModel, questViewModel: questViewModel, selection: $selection)
            case .statistic:
                StatisticView(timerViewModel: timerViewModel, questViewModel: questViewModel, selection: $selection)
            }
        } else {
            OnboardingView(userViewModel: userViewModel)
        }
    }
}

#Preview {
    ContentView()
        .frame(maxWidth: 800, maxHeight: 500)
}
