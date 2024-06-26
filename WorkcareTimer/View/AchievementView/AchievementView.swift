//
//  AchievementView.swift
//  WorkcareTimer
//
//  Created by Elian Richard on 22/05/24.
//

import SwiftUI
import SwiftData

struct AchievementView: View {
    @EnvironmentObject private var cloudQuestViewModel: CloudQuestViewModel
    @EnvironmentObject private var cloudFlowViewModel: CloudFlowViewModel
    @Binding var selection: MenuItems
    
    private var quests: [QuestItem] {
        cloudQuestViewModel.quests
    }
    private var flows: [FlowItem] {
        cloudFlowViewModel.flows
    }
    var questsSum: [String: Int] {
        return quests.reduce(into: [:]) { counts, element in
            counts[element.category, default: 0] += 1
        }
    }
    var flowSum: [String: Int] {
        return flows.reduce(into: [:]) { counts, element in
            counts[element.category, default: 0] += 1
        }
    }
    
    var achievementList = AchievementList()
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        LayoutView (selection: $selection) {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(achievementList.list) { achievement in
                        Text(getAchievementText(achievement))
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity)
                            .frame(height: 60)
                            .padding(.horizontal, 10)
                            .background(isAchievementDone(achievement) ? .black : .blackBg)
                            .clipShape(RoundedRectangle(cornerRadius: 6))
                            .foregroundStyle(isAchievementDone(achievement) ? .white : .gray)
                    }
                }
            }
            .frame(maxWidth: 800)
            .padding(.vertical)
            .foregroundColor(.white)
            
            HStack (spacing: 4) {
                Text("\(getAchievementCount()) of \(achievementList.list.count) achievements acquired")
                    .font(.caption)
                    .foregroundStyle(.white)
            }
            .frame(maxWidth: .infinity)
        }
        .task {
            do {
                try await cloudQuestViewModel.populateQuests()
                try await cloudFlowViewModel.populateFlows()
            } catch {
                print(error)
            }
        }
    }
    
    func getAchievementText (_ item: AchievementItem) -> String {
        let baseText = item.achievementText
        if (item.category == .health(.drink)) {
            let value = item.value / HealthCategory.drink.questUnitDivider
            return baseText.replacingOccurrences(of: "{value}", with: String(value))
        } else {
            return baseText.replacingOccurrences(of: "{value}", with: item.value.formatted())
        }
    }
    
    func isAchievementDone (_ item: AchievementItem) -> Bool {
        if (
            item.category.mainCategory == .flow
        ) {
            if (item.category.categoryId == "allFlow") {
                let achievedValue = flows.count
                return achievedValue >= item.value
            } else {
                for type in WorkFlowType.allCases {
                    if (type.id == item.category.categoryId) {
                        let achievedValue = flowSum[type.id] ?? 0
                        return achievedValue >= item.value
                    }
                }
                return false
            }
        } else {
            for type in HealthCategory.allCases {
                if (type.id == item.category.categoryId) {
                    let achievedValue = questsSum[type.id] ?? 0
                    return achievedValue * type.questValue >= item.value
                }
            }
            return false
        }
    }
    
    func getAchievementCount () -> Int {
        var count = 0
        for achievement in achievementList.list {
            if isAchievementDone(achievement) {
                count += 1
            }
        }
        return count
    }
}

#Preview {
    AchievementView(selection: .constant(.achievement))
        .frame(maxWidth: 800, maxHeight: 500)
}
