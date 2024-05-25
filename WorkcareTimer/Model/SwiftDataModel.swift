//
//  AchievementViewModel.swift
//  WorkcareTimer
//
//  Created by Elian Richard on 25/05/24.
//

import Foundation
import SwiftData

@Model
class QuestModel: Identifiable {
    var id: UUID
    var questCategory: HealthCategory
    
    init(questCategory: HealthCategory) {
        self.id = UUID()
        self.questCategory = questCategory
    }
}

@Model
class FlowModel {
    var id: UUID
    var workflow: WorkFlowType
    
    init(workflow: WorkFlowType) {
        self.id = UUID()
        self.workflow = workflow
    }
}
