//
//  QuestViewModel.swift
//  WorkcareTimer
//
//  Created by Elian Richard on 22/05/24.
//

import Foundation

@Observable class QuestViewModel: ObservableObject {
    var doneQuests: [String: QuestItem] = [:]
    
    var totalLifetimeCompletion: [HealthCategory: Int] = [.drink: 0, .stand: 0, .walk: 0, .breathe: 0]
    
    func modifyCompletion (_ completedCategory: HealthCategory) {
        if var lifetimeCompletion = self.totalLifetimeCompletion[completedCategory] {
            if (doneQuests.containsKey(completedCategory.id)) {
                lifetimeCompletion -= completedCategory.questValue
                self.totalLifetimeCompletion[completedCategory] = lifetimeCompletion
                self.doneQuests.removeValue(forKey: completedCategory.id)
            } else {
                lifetimeCompletion += completedCategory.questValue
                self.totalLifetimeCompletion[completedCategory] = lifetimeCompletion
                let newItem = QuestItem(category: completedCategory.id, dateCompleted: Date(), value: completedCategory.questValue)
                self.doneQuests[newItem.category] = newItem
            }
        }
    }
    
    func resetDoneQuestIndex () {
        self.doneQuests = [:]
    }
    
    func resetQuestCompletion () {
        self.totalLifetimeCompletion = [.drink: 0, .stand: 0, .walk: 0, .breathe: 0]
    }
}

