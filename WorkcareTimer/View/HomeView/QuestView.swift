//
//  QuestView.swift
//  WorkcareTimer
//
//  Created by Elian Richard on 22/05/24.
//

import SwiftUI

struct QuestView: View {
    @EnvironmentObject private var cloudQuestViewModel: CloudQuestViewModel
    @ObservedObject var questViewModel: QuestViewModel
    
    var body: some View {
        VStack (spacing: 10) {
            ForEach (HealthCategory.allCategories) { category in
                Button {
                    questViewModel.modifyCompletion(category)
                } label: {
                    HStack (alignment: .top) {
                        Image(systemName: questViewModel.doneQuests.containsKey(category.id) ? "checkmark.circle.fill" : "circle")
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
