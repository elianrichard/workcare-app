//
//  ClockView.swift
//  WorkcareTimer
//
//  Created by Elian Richard on 21/05/24.
//

import SwiftUI

struct TimerClockView: View {
    @EnvironmentObject private var cloudFlowViewModel: CloudFlowViewModel
    @EnvironmentObject private var cloudQuestViewModel: CloudQuestViewModel
    
    @ObservedObject var timerViewModel: TimerViewModel
    @ObservedObject var questViewModel: QuestViewModel
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        Text(secondsToTime(timerViewModel.timeRemaining))
            .foregroundStyle(.white)
            .font(.system(size: 85).monospacedDigit())
            .frame(height: 60)
            .fontWeight(.bold)
            .onReceive(timer) { _ in
                if timerViewModel.isPaused {
                    return
                }
                if timerViewModel.timeRemaining > 0 {
                    timerViewModel.timeRemaining -= 1
                } else {
                    let currentFlow = timerViewModel.currentFlow.id
                    Task {
                        try await cloudFlowViewModel.addFlow(FlowItem(category: currentFlow, dateCompleted: Date()))
                        for category in HealthCategory.allCases {
                            if let newItem = questViewModel.doneQuests[category.id] {
                                try await cloudQuestViewModel.addQuest(newItem)
                            }
                        }
                    }
                    timerViewModel.startNextFlow(questViewModel: questViewModel)
                }
            }
    }
    
    func secondsToTime (_ second: Int) -> String {
        let hourInt = second / 3600
        let hour = addZeroString(hourInt)
        let minute = addZeroString((second % 3600) / 60)
        let second = addZeroString((second % 3600) % 60)
        if (hourInt > 0) {
            return "\(hour):\(minute):\(second)"
        } else {
            return "\(minute):\(second)"
        }
        
    }
    
    func addZeroString (_ number: Int) -> String {
        if (number >= 10) {
            return "\(number)"
        } else {
            return "0\(number)"
        }
    }
}

#Preview {
    TimerClockView(timerViewModel: TimerViewModel(), questViewModel: QuestViewModel()).frame(minWidth: 400)
}
