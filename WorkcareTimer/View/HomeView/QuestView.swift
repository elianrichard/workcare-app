//
//  QuestView.swift
//  WorkcareTimer
//
//  Created by Elian Richard on 22/05/24.
//

import SwiftUI
import SwiftData

struct QuestView: View {
    @Environment(\.modelContext) private var context
    
    @ObservedObject var questViewModel: QuestViewModel
    
    @Query var questsCompletion: [QuestModel]
    
    var body: some View {
        VStack (spacing: 10) {
            ForEach (HealthCategory.allCategories) { category in
                Button {
                    if questViewModel.doneQuests[category] ?? false {
                        let item = questsCompletion.filter { $0.questCategory == category }.last ?? QuestModel(.drink)
                        context.delete(item)
                    } else {
                        context.insert(QuestModel(category))
                    }
                    questViewModel.modifyCompletion(category)
                } label: {
                    HStack (alignment: .top) {
                        Image(systemName: questViewModel.doneQuests[category] ?? false ? "checkmark.circle.fill" : "circle")
                        Text(category.questText)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .buttonStyle(PlainButtonStyle())
                .focusEffectDisabled()
            }
        }
    }
}

#Preview {
    QuestView(questViewModel: QuestViewModel())
}
