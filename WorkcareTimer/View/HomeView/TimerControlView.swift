//
//  TimerControlView.swift
//  WorkcareTimer
//
//  Created by Elian Richard on 21/05/24.
//

import SwiftUI

struct TimerControlView: View {
    @ObservedObject var timerViewModel: TimerViewModel
    
    var body: some View {
        HStack (spacing: 5) {
            Button {
                if (timerViewModel.isFlowDone) {
                    timerViewModel.initializeFlow()
                } else {
                    timerViewModel.togglePause()                    
                }
            } label: {
                Image(systemName: timerViewModel.isPaused ? "play.fill" : "pause.fill")
                    .foregroundStyle(.black)
                    .frame(width: 30, height: 30)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
            }
            .buttonStyle(PlainButtonStyle())
            .focusEffectDisabled()
            
            Button {
                timerViewModel.resetTimer()
            } label: {
                Image(systemName: "arrow.circlepath")
                    .foregroundStyle(.black)
                    .frame(width: 30, height: 30)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
            }
            .buttonStyle(PlainButtonStyle())
            .focusEffectDisabled()
        }
    }
}

#Preview {
    TimerControlView(timerViewModel: TimerViewModel())
}
