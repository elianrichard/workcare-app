//
//  SettingView.swift
//  WorkcareTimer
//
//  Created by Elian Richard on 22/05/24.
//

import SwiftUI

struct SettingView: View {
    @Binding var selection: MenuItems
    
    var body: some View {
        VStack {
            Text("Setting")
            Button {
                selection = .home
            } label: {
                Text("Back to Home")
            }
        }
    }
}

#Preview {
    SettingView(selection: .constant(.setting))
        .frame(maxWidth: 800, maxHeight: 500)
}
