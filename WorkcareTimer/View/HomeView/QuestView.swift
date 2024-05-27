//
//  QuestView.swift
//  WorkcareTimer
//
//  Created by Elian Richard on 22/05/24.
//

import SwiftUI

struct QuestView: View {
    @ObservedObject var questViewModel: QuestViewModel
    
    var body: some View {
        VStack (spacing: 10) {
            ForEach (HealthCategory.allCategories) { category in
                Button {
                    if questViewModel.doneQuests[category] ?? false {
                        questViewModel.removeQuestItem(QuestModel(category))
                    } else {
                        questViewModel.addQuestItem(QuestModel(category))
//                        Task {
//                            try await cloudViewModel.addQuest(QuestItem(category: category.id, dateCompleted: Date(), value: category.questValue))
//                        }
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
