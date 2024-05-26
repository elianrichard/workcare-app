//
//  TimerControlView.swift
//  WorkcareTimer
//
//  Created by Elian Richard on 21/05/24.
//

import SwiftUI

struct TimerControlView: View {
    @ObservedObject var timerViewModel: TimerViewModel
    @ObservedObject var questViewModel: QuestViewModel
    
    var body: some View {
        HStack (spacing: 5) {
            Button {
                timerViewModel.initializeFlow(questViewModel: questViewModel)
            } label: {
                Image(systemName: "backward.fill")
                    .foregroundStyle(.black)
                    .frame(width: 30, height: 30)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
            }
            .buttonStyle(PlainButtonStyle())
            .focusEffectDisabled()
            
            Button {
                if (!timerViewModel.isFlowDone) {
                    timerViewModel.togglePause()                    
                }
            } label: {
                Image(systemName: timerViewModel.isPaused ? "play.fill" : "pause.fill")
                    .foregroundStyle(.black)
                    .frame(width: 30, height: 30)
                    .background(!timerViewModel.isFlowDone ? .white : .gray)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
            }
            .buttonStyle(PlainButtonStyle())
            .focusEffectDisabled()
            
            Button {
                if !timerViewModel.isFlowDone {
                    timerViewModel.resetTimer()
                }
            } label: {
                Image(systemName: "arrow.circlepath")
                    .foregroundStyle(.black)
                    .frame(width: 30, height: 30)
                    .background(!timerViewModel.isFlowDone ? .white : .gray)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
            }
            .buttonStyle(PlainButtonStyle())
            .focusEffectDisabled()
        }
    }
}

#Preview {
    TimerControlView(timerViewModel: TimerViewModel(), questViewModel: QuestViewModel())
}
