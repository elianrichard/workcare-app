//
//  StatisticView.swift
//  WorkcareTimer
//
//  Created by Elian Richard on 22/05/24.
//

import SwiftUI

struct StatisticView: View {
    @Binding var selection: MenuItems
    
    var body: some View {
        VStack {
            Text("Statistic")
            Button {
                selection = .home
            } label: {
                Text("Back to Home")
            }
        }
    }
}

#Preview {
    StatisticView(selection: .constant(.statistic))
        .frame(maxWidth: 800, maxHeight: 500)
}
