//
//  TimerView.swift
//  WorkcareTimer
//
//  Created by Elian Richard on 21/05/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject var timerViewModel = TimerViewModel()
    @StateObject var questViewModel = QuestViewModel()
    @Binding var selection: MenuItems
    
    var body: some View {
        GeometryReader { geometry in
            ZStack (alignment: .center) {
                Image(.timerBg)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                VStack {
                    HeaderView(selection: $selection)
                    Spacer()
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
                            Text("Recap View")
                            .frame(maxWidth: 250)
                            .onAppear {
                                print(questViewModel.totalCompletion)
                            }
                        }
                    }
                    .frame(maxWidth: 600)
                    Spacer()
                    TimerControlView(timerViewModel: timerViewModel)
                }
                .padding(20)
                .frame(width: geometry.size.width * 0.85, height: geometry.size.height * 0.8)
                .background(.blackBg)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    HomeView(selection: .constant(.home))
        .frame(maxWidth: 800, maxHeight: 500)
}
