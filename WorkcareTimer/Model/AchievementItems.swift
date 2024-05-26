//
//  AchievementModel.swift
//  WorkcareTimer
//
//  Created by Elian Richard on 26/05/24.
//

import Foundation

enum MainCategory {
    case flow
    case health
}

enum HealthOrFlow: Equatable {
    case health(HealthCategory)
    case flow(WorkFlowType)
    case allFlow
    
    var achievementDescription: String {
        switch self {
        case .health(let category):
            return category.achievementDescription
        case .flow(let workflow):
            return workflow.achievementDescription
        case .allFlow:
            return "Acquire the total of {value} flows of all period"
        }
    }
    
    var mainCategory: MainCategory {
        switch self {
        case .health:
            return MainCategory.health
        case .flow:
            return MainCategory.flow
        case .allFlow:
            return MainCategory.flow
        }
    }
    
    var categoryId: String {
        switch self {
        case .health(let category):
            return category.id
        case .flow(let workflow):
            return workflow.id
        case .allFlow:
            return "allFlow"
        }
    }
}

struct AchievementItem: Identifiable {
    var id: UUID
    var achievementText: String
    var category: HealthOrFlow
    var value: Int
    
    init(category: HealthOrFlow, value: Int) {
        self.id = UUID()
        self.achievementText = category.achievementDescription
        self.category = category
        self.value = value
    }
}

struct AchievementList {
    var list: [AchievementItem] = [
        AchievementItem(category: .allFlow, value: 10),
        AchievementItem(category: .allFlow, value: 100),
        AchievementItem(category: .allFlow, value: 1_000),
        AchievementItem(category: .flow(.focus), value: 10),
        AchievementItem(category: .flow(.focus), value: 100),
        AchievementItem(category: .flow(.focus), value: 1_000),
        AchievementItem(category: .flow(.short), value: 10),
        AchievementItem(category: .flow(.short), value: 100),
        AchievementItem(category: .flow(.short), value: 1_000),
        AchievementItem(category: .flow(.long), value: 10),
        AchievementItem(category: .flow(.long), value: 100),
        AchievementItem(category: .flow(.long), value: 1_000),
        AchievementItem(category: .health(.drink), value: 3_000),
        AchievementItem(category: .health(.drink), value: 30_000),
        AchievementItem(category: .health(.drink), value: 300_000),
        AchievementItem(category: .health(.stand), value: 60),
        AchievementItem(category: .health(.stand), value: 600),
        AchievementItem(category: .health(.stand), value: 3600),
        AchievementItem(category: .health(.walk), value: 100),
        AchievementItem(category: .health(.walk), value: 1_000),
        AchievementItem(category: .health(.walk), value: 10_000),
        AchievementItem(category: .health(.breathe), value: 60),
        AchievementItem(category: .health(.breathe), value: 600),
        AchievementItem(category: .health(.breathe), value: 3600),
    ]
}
