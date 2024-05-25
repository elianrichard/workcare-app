//
//  QuestViewModel.swift
//  WorkcareTimer
//
//  Created by Elian Richard on 22/05/24.
//

import Foundation

enum HealthCategory {
    case drink
    case stand
    case walk
    case breathIn
    case breathOut
}

struct QuestModel: Identifiable {
    var id: UUID = UUID()
    var questTitle: String
    var category: HealthCategory
    var value: Int
}

@Observable class QuestViewModel: ObservableObject {
    var quests: [QuestModel] = [
        QuestModel(questTitle: "Drink 300 ml of water", category: .drink, value: 300),
        QuestModel(questTitle: "Stand up & stretch for 60 seconds", category: .stand, value: 60),
        QuestModel(questTitle: "Walk 20 steps", category: .drink, value: 20),
        QuestModel(questTitle: "Take a deep breath for 5 seconds", category: .breathIn, value: 5),
        QuestModel(questTitle: "Exhale breath for 5 seconds", category: .breathOut, value: 5),
    ]
    var doneQuestIndex: [Int] = []
    
    var totalCompletion: [HealthCategory: [Int]] = [.drink: [], .stand: [], .walk: [], .breathIn: [], .breathOut: []]
    
    func addCompletion (_ completedQuest: QuestModel) {
        if var currentCompletion = totalCompletion[completedQuest.category] {
            print(currentCompletion, completedQuest.category)
            currentCompletion.append(completedQuest.value)
            print(currentCompletion)
            totalCompletion[completedQuest.category] = currentCompletion
        }
    }
    
    func removeCompletion (_ completedQuest: QuestModel) {
        if var currentCompletion = totalCompletion[completedQuest.category] {
            currentCompletion.popLast()
            totalCompletion[completedQuest.category] = currentCompletion
        }
    }
    
    func resetDoneQuestIndex () {
        self.doneQuestIndex = []
    }
}

