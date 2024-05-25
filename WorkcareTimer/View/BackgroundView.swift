//
//  BackgroundView.swift
//  WorkcareTimer
//
//  Created by Elian Richard on 25/05/24.
//

import SwiftUI

struct BackgroundView: View {
    var selection: MenuItems
    
    var body: some View {
        Image(selection.bgImage)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    BackgroundView(selection: .home)
}
