//
//  TimerViewModel.swift
//  WorkcareTimer
//
//  Created by Elian Richard on 21/05/24.
//

import SwiftUI
import UserNotifications

@Observable class TimerViewModel: ObservableObject {
    var timeRemaining: Int = 0
    var currentFlowIndex: Int = 0
    var currentFlow: WorkFlowType
    var isPaused: Bool = true
    var isFlowDone: Bool = false
    var isShowQuest: Bool = false
    
    init(timeRemaining: Int = 0, currentFlowIndex: Int = 0) {
        self.currentFlowIndex = currentFlowIndex
        self.currentFlow = WorkFlowValue().workflows[currentFlowIndex].type
        self.timeRemaining = WorkFlowValue().timer[currentFlow] ?? 0
    }
    
    func startNextFlow (questViewModel: QuestViewModel) {
        let newIndex = currentFlowIndex + 1
        if (currentFlowIndex < WorkFlowValue().workflows.count - 1) {
            let newFlow = WorkFlowValue().workflows[newIndex].type
            self.currentFlow = newFlow
            self.timeRemaining = WorkFlowValue().timer[currentFlow] ?? 0
            if (newFlow == .focus) {
                showFlowNotification(title: "Your break is over!", subtitle: "Time to focus again.")
                withAnimation(.easeInOut(duration: 1)) {
                    self.isShowQuest = false
                }
            } else {
                if (newFlow == .long) {
                    showFlowNotification(title: "Your Last Focus Time is Up!", subtitle: "Take a break and do some healthy task to earn some coins!")
                } else {
                    showFlowNotification(title: "Your Focus Time is Up!", subtitle: "Take a break and do some healthy task to earn some coins!")
                }
                questViewModel.resetDoneQuestIndex()
                withAnimation(.easeInOut(duration: 1)) {
                    self.isShowQuest = true
                }
            }
        } else {
            self.isPaused = true
            withAnimation(.easeInOut(duration: 1)) {
                self.isFlowDone = true
                self.isShowQuest = false
            }
        }
        self.currentFlowIndex = newIndex
    }
    
    func initializeFlow (questViewModel: QuestViewModel) {
        questViewModel.resetQuestCompletion()
        let newIndex = 0
        self.currentFlowIndex = newIndex
        self.currentFlow = WorkFlowValue().workflows[newIndex].type
        self.timeRemaining = WorkFlowValue().timer[currentFlow] ?? 0
        self.isPaused = true
        withAnimation(.easeInOut(duration: 1)) {
            self.isShowQuest = false
            self.isFlowDone = false
        }
    }
    
    func togglePause () {
        requestNotificationPermission { isGranted in
            if (isGranted) {
                self.isPaused.toggle()
            }
        }
    }
    
    func resetTimer() {
        self.timeRemaining = WorkFlowValue().timer[currentFlow] ?? 0
        self.isPaused = true
    }
    
    func requestNotificationPermission(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                completion(true)
            } else {
                if let error = error {
                    print(error.localizedDescription)
                }
                completion(false)
            }
        }
    }

    
    func showFlowNotification (title: String, subtitle: String) {
        let content = UNMutableNotificationContent()
        content.title = "\(title)"
        content.subtitle = "\(subtitle)"
        content.sound = UNNotificationSound.default
        
        // show this notification five seconds from now
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.1, repeats: false)
        
        
        // choose a random identifier
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        // add our notification request
        UNUserNotificationCenter.current().add(request)
    }
}
