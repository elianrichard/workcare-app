//
//  StatisticView.swift
//  WorkcareTimer
//
//  Created by Elian Richard on 22/05/24.
//

import SwiftUI
import SwiftData

struct StatisticView: View {
    @Environment(\.modelContext) var modelContext
    
    @Binding var selection: MenuItems
    
    @Query private var allCompletedQuest: [QuestModel]
    
    var questsSum: [HealthCategory: Int] {
        return allCompletedQuest.reduce(into: [:]) { counts, element in
            counts[element.questCategory, default: 0] += 1
        }
    }
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    init(selection: Binding<MenuItems>) {
        self._selection = selection
    }
    
    var body: some View {
        LayoutView (selection: $selection) {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach (HealthCategory.allCategories) { category in
                        VStack (spacing: 8) {
                            Text("\((questsSum[category] ?? 0) * category.questValue) \(category.questUnit)")
                                .font(.title)
                                .fontWeight(.bold)
                            Text(category.recapText)
                                .font(.title3)
                        }
                        .frame(maxWidth: 500)
                        .foregroundColor(.white)
                    }
                }
            }
            .padding(.vertical)
            
            Button {
                for quest in allCompletedQuest {
                    modelContext.delete(quest)
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
    }
}

#Preview {
    StatisticView(selection: .constant(.statistic))
        .frame(maxWidth: 800, maxHeight: 500)
}
