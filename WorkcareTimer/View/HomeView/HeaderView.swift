//
//  HeaderView.swift
//  WorkcareTimer
//
//  Created by Elian Richard on 22/05/24.
//

import SwiftUI

struct HeaderView: View {
    @Binding var selection: MenuItems
    var isShowQuotes: Bool = false
    
    var body: some View {
        HStack (alignment: .top) {
            HStack (spacing: 5) {
                ForEach (MenuItems.allCases) { menu in
                    Button {
                        withAnimation {
                            selection = menu
                        }
                    } label: {
                        Image(systemName: menu.iconName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: menu.iconSize, height: menu.iconSize)
                            .foregroundStyle(.white)
                            .frame(width: 25, height: 25)
                            .background(.blackBg)
                            .clipShape(RoundedRectangle(cornerRadius: 6))
                    }
                    .buttonStyle(PlainButtonStyle())
                    .focusEffectDisabled()
                }
            }
            Spacer()
            if isShowQuotes {
                Text("“Lost time is never found again.”\n– Benjamin Franklin")
                    .font(.title3)
                    .multilineTextAlignment(.trailing)
                    .foregroundStyle(.white)
            } else {
                Text(selection.displayName)
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
            }
        }
    }
}

#Preview {
    HeaderView(selection: .constant(.home))
}
