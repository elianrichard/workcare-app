//
//  QuestViewModel.swift
//  WorkcareTimer
//
//  Created by Elian Richard on 22/05/24.
//

import Foundation
import SwiftData

@Observable class QuestViewModel: ObservableObject {
    var doneQuests: [HealthCategory: Bool] = [.drink: false, .stand: false, .walk: false, .breath: false]
    
    var totalLifetimeCompletion: [HealthCategory: Int] = [.drink: 0, .stand: 0, .walk: 0, .breath: 0]
    
    var totalFlowCompletion: [HealthCategory: [Int]] = [.drink: [], .stand: [], .walk: [], .breath: []]
    
    func modifyCompletion (_ completedCategory: HealthCategory) {
        if var currentCompletion = self.totalFlowCompletion[completedCategory],
           var lifetimeCompletion = self.totalLifetimeCompletion[completedCategory] {
            if (doneQuests[completedCategory] ?? false) {
                _ = currentCompletion.popLast()
                lifetimeCompletion -= completedCategory.questValue
                self.doneQuests[completedCategory] = false
                self.totalFlowCompletion[completedCategory] = currentCompletion
                self.totalLifetimeCompletion[completedCategory] = lifetimeCompletion
            } else {
                currentCompletion.append(completedCategory.questValue)
                lifetimeCompletion += completedCategory.questValue
                self.doneQuests[completedCategory] = true
                self.totalFlowCompletion[completedCategory] = currentCompletion
                self.totalLifetimeCompletion[completedCategory] = lifetimeCompletion
            }
        }
    }
    
    func resetDoneQuestIndex () {
        self.doneQuests = [.drink: false, .stand: false, .walk: false, .breath: false]
        self.totalFlowCompletion = [.drink: [], .stand: [], .walk: [], .breath: []]
    }
    
    func getRecapValue (_ category: HealthCategory) -> Int {
        let categoryRecap = totalFlowCompletion[category] ?? []
        return categoryRecap.reduce(0, +)
    }
}

