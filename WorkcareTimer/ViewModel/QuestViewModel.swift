//
//  QuestViewModel.swift
//  WorkcareTimer
//
//  Created by Elian Richard on 22/05/24.
//

import Foundation

@Observable class QuestViewModel: ObservableObject {
    var questStorage: [QuestModel] = []
    
    var doneQuests: [HealthCategory: Bool] = [.drink: false, .stand: false, .walk: false, .breathe: false]
    
    var totalLifetimeCompletion: [HealthCategory: Int] = [.drink: 0, .stand: 0, .walk: 0, .breathe: 0]
    
    var totalFlowCompletion: [HealthCategory: [Int]] = [.drink: [], .stand: [], .walk: [], .breathe: []]
    
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
                print(completedCategory, totalFlowCompletion, currentCompletion, "\n-----\n")
                currentCompletion.append(completedCategory.questValue)
                lifetimeCompletion += completedCategory.questValue
                self.doneQuests[completedCategory] = true
                self.totalFlowCompletion[completedCategory] = currentCompletion
                self.totalLifetimeCompletion[completedCategory] = lifetimeCompletion
                print(completedCategory, totalFlowCompletion, currentCompletion, "\n=====\n")
            }
        }
    }
    
    func resetDoneQuestIndex () {
        self.doneQuests = [.drink: false, .stand: false, .walk: false, .breathe: false]
    }
    
    func resetQuestCompletion () {
        self.totalFlowCompletion = [.drink: [], .stand: [], .walk: [], .breathe: []]
    }
    
    func getRecapValue (_ category: HealthCategory) -> Int {
        let categoryRecap = totalFlowCompletion[category] ?? []
        return categoryRecap.reduce(0, +)
    }
    
    func addQuestItem (_ quest: QuestModel) {
        questStorage.append(quest)
    }
    
    func removeQuestItem (_ quest: QuestModel) {
        if let index = questStorage.lastIndex(where: { $0.questCategory == quest.questCategory }){
            questStorage.remove(at: index)
        }
    }
    
    func resetQuestStorage () {
        questStorage = []
    }
}

