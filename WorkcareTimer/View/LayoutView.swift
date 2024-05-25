//
//  LayoutView.swift
//  WorkcareTimer
//
//  Created by Elian Richard on 25/05/24.
//

import SwiftUI

struct LayoutView<Content: View>: View {
    @Binding var selection: MenuItems
    var isShowQuotes: Bool
    let content: () -> Content
    
    init(selection: Binding<MenuItems>,
         isShowQuotes: Bool = false,
         @ViewBuilder content: @escaping () -> Content) {
        self._selection = selection
        self.isShowQuotes = isShowQuotes
        self.content = content
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack (alignment: .center) {
                Image(selection.bgImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                VStack {
                    HeaderView(selection: $selection, isShowQuotes: isShowQuotes)
                    Spacer()
                    content()
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
    LayoutView(selection: .constant(.home)){
        Text("Content")
        Spacer()
    }
        .frame(maxWidth: 800, maxHeight: 500)
}
