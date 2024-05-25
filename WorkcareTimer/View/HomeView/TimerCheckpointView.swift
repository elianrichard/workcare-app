//
//  TimerCheckpointView.swift
//  WorkcareTimer
//
//  Created by Elian Richard on 21/05/24.
//

import SwiftUI

struct TimerCheckpointView: View {
    @ObservedObject var timerViewModel: TimerViewModel
    
    var body: some View {
        HStack {
            ForEach (Array(WorkFlowValue().workflows.enumerated()), id: \.element.id) { index, workflow in
                Image(systemName:
                        index < timerViewModel.currentFlowIndex
                      ? workflow.type.doneIcon
                      : workflow.type.initialIcon)
                .resizable()
                .scaledToFit()
                .foregroundStyle(.white)
                .frame(width: workflow.type.iconSize)
                .symbolEffect(
                    .pulse.wholeSymbol,
                    options: .speed(1),
                    isActive: index == timerViewModel.currentFlowIndex
                )
            }
        }
    }
}

#Preview {
    TimerCheckpointView(timerViewModel: TimerViewModel())
}
