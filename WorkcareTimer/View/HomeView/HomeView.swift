//
//  TimerView.swift
//  WorkcareTimer
//
//  Created by Elian Richard on 21/05/24.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var timerViewModel: TimerViewModel
    @ObservedObject var questViewModel: QuestViewModel
    @Binding var selection: MenuItems
    
    var body: some View {
        LayoutView (selection: $selection, isShowQuotes: true) {
            HStack (alignment: .center, spacing: 20) {
                VStack (spacing: 20) {
                    TimerClockView(timerViewModel: timerViewModel, questViewModel: questViewModel)
                    TimerCheckpointView(timerViewModel: timerViewModel)
                }
                .frame(maxWidth: .infinity)
                if timerViewModel.isShowQuest {
                    QuestView(questViewModel: questViewModel)
                        .frame(maxWidth: 250)
                } else if timerViewModel.isFlowDone {
                    RecapView(questViewModel: questViewModel)
                }
            }
            .frame(maxWidth: 600)
            Spacer()
            TimerControlView(timerViewModel: timerViewModel, questViewModel: questViewModel)
        }
    }
}

#Preview {
    HomeView(timerViewModel: TimerViewModel(), questViewModel: QuestViewModel(), selection: .constant(.home))
        .frame(maxWidth: 800, maxHeight: 500)
}
