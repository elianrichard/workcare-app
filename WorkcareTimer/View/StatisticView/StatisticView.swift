//
//  StatisticView.swift
//  WorkcareTimer
//
//  Created by Elian Richard on 22/05/24.
//

import SwiftUI

struct StatisticView: View {
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
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        LayoutView (selection: $selection) {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    VStack (spacing: 8) {
                        Text("\(flows.count) ")
                            .font(.title)
                            .fontWeight(.bold)
                        + Text(WorkFlowType.flowUnit)
                            .font(.title3)
                            .fontWeight(.bold)
                        Text("of all flow period in total")
                            .font(.subheadline)
                    }
                    ForEach (WorkFlowType.allFlows) { flow in
                        VStack (spacing: 8) {
                            Text("\(flowSum[flow.id] ?? 0) ")
                                .font(.title)
                                .fontWeight(.bold)
                            + Text(WorkFlowType.flowUnit)
                                .font(.title3)
                                .fontWeight(.bold)
                            Text(flow.statisticDescription)
                                .font(.subheadline)
                        }
                    }
                    ForEach (HealthCategory.allCategories) { category in
                        VStack (spacing: 8) {
                            Text("\(getHealthCategoryValue(category)) ")
                                .font(.title)
                                .fontWeight(.bold)
                            + Text(category.questUnit)
                                .font(.title3)
                                .fontWeight(.bold)
                            Text(category.recapText)
                                .font(.subheadline)
                        }
                    }
                }
            }
            .frame(maxWidth: 800)
            .padding(.vertical)
            .foregroundColor(.white)
            
            Button {
                Task {
                    try await cloudQuestViewModel.resetQuest()
                    try await cloudFlowViewModel.resetFlow()
                }
            } label: {
                HStack (spacing: 4) {
                    Image(systemName: "arrow.circlepath")
                        .foregroundStyle(.white)
                        .frame(width: 20, height: 20)
                    Text("Reset Progress")
                        .font(.caption)
                        .foregroundStyle(.white)
                }
            }
            .buttonStyle(PlainButtonStyle())
            .frame(maxWidth: .infinity, alignment: .trailing)
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
    
    func getHealthCategoryValue (_ category: HealthCategory) -> String {
        let value =  Double(questsSum[category.id] ?? 0) * Double(category.questValue)
        if category.questUnitDivider != 1 {
            let unitConversion = value / Double(category.questUnitDivider)
            return String(format: "%.1f", unitConversion)
        } else {
            return String(format: "%.0f", value)
        }
    }
}

#Preview {
    StatisticView(selection: .constant(.statistic))
        .frame(maxWidth: 800, maxHeight: 500)
}
