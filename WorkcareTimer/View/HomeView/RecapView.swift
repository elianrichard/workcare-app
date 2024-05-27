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
                    Text("**\(getRecapValue(category)) \(category.questUnit)** \(category.recapText)")
                        .font(.title3)
                }
            }
        }
        .frame(maxWidth: 250)
    }
    
    func getRecapValue (_ category: HealthCategory) -> String {
        let value = questViewModel.totalLifetimeCompletion[category] ?? 0
        let divided = Double(value) / Double(category.questUnitDivider)
        if (category == .drink) {
            return String(format: "%.1f", divided)
        } else {
            return String(format: "%.0f", divided)
        }
    }
}

#Preview {
    RecapView(questViewModel: QuestViewModel())
}
