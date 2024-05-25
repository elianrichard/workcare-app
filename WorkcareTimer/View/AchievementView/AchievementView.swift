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
        LayoutView(selection: $selection) {
            Text("Hello")
            Spacer()
        }
    }
}

#Preview {
    AchievementView(selection: .constant(.achievement))
        .frame(maxWidth: 800, maxHeight: 500)
}
