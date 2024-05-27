//
//  AchievementViewModel.swift
//  WorkcareTimer
//
//  Created by Elian Richard on 25/05/24.
//

import Foundation

struct QuestModel: Identifiable {
    var id: UUID
    var questCategory: HealthCategory
    
    init(_ questCategory: HealthCategory) {
        self.id = UUID()
        self.questCategory = questCategory
    }
}

struct FlowModel: Identifiable {
    var id: UUID
    var workflow: WorkFlowType
    
    init(_ workflow: WorkFlowType) {
        self.id = UUID()
        self.workflow = workflow
    }
}
