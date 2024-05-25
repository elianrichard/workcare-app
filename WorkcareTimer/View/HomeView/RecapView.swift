//
//  RecapView.swift
//  WorkcareTimer
//
//  Created by Elian Richard on 25/05/24.
//

import SwiftUI

struct RecapView: View {
    @ObservedObject var questViewModel: QuestViewModel
    
    var body: some View {
        VStack (alignment: .leading, spacing: 10) {
            Text("Congratulation!")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.leading)
            Text("You just finished a cycle, here is your quest completion recap.")
                .multilineTextAlignment(.leading)
            VStack (alignment: .leading, spacing: 5) {
                ForEach(HealthCategory.allCategories) { category in
                    Text("**\(questViewModel.getRecapValue(category)) \(category.questUnit)** \(category.recapText)")
                        .font(.title3)
                }
            }
        }
        .frame(maxWidth: 250)
    }
}

#Preview {
    RecapView(questViewModel: QuestViewModel())
}
