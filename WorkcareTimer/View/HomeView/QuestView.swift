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
            ForEach (Array(questViewModel.quests.enumerated()), id: \.element.id) { index, quest in
                Button {
                    if (questViewModel.doneQuestIndex.contains(index)) {
                        if let arrIndex = questViewModel.doneQuestIndex.firstIndex(of: index) {
                            questViewModel.doneQuestIndex.remove(at: arrIndex)
                            questViewModel.removeCompletion(quest)
                        }
                    } else {
                        questViewModel.doneQuestIndex.append(index)
                        questViewModel.addCompletion(quest)
                    }
                } label: {
                    HStack (alignment: .top) {
                        Image(systemName: questViewModel.doneQuestIndex.contains(index) ? "checkmark.circle.fill" : "circle")
                        Text(quest.questTitle)
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
