//
//  AchievementView.swift
//  WorkcareTimer
//
//  Created by Elian Richard on 22/05/24.
//

import SwiftUI

struct AchievementView: View {
    @Binding var selection: MenuItems
    
    var body: some View {
        VStack {
            Text("Achievement")
            Button {
                selection = .home
            } label: {
                Text("Back to Home")
            }
        }
    }
}

#Preview {
    AchievementView(selection: .constant(.achievement))
        .frame(maxWidth: 800, maxHeight: 500)
}
