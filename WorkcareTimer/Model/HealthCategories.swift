//
//  HealthCategories.swift
//  WorkcareTimer
//
//  Created by Elian Richard on 25/05/24.
//

import Foundation

enum HealthCategory: Identifiable, CaseIterable, Hashable, Codable {
    case drink
    case stand
    case walk
    case breath
    
    var id: String {
        switch self {
        case .drink: "drink"
        case .stand: "stand"
        case .walk: "walk"
        case .breath: "breath"
        }
    }
    
    var questText: String {
        switch self {
        case .drink: "Drink 300 ml of water"
        case .stand: "Stand up & stretch for 60 seconds"
        case .walk: "Walk 20 steps"
        case .breath: "Inhale and Exhale breath for 10 seconds"
        }
    }
    
    var questUnit: String {
        switch self {
        case .drink: "ml"
        case .stand: "second(s)"
        case .walk: "step(s)"
        case .breath: "second(s)"
        }
    }
    
    var recapText: String {
        switch self {
        case .drink: "of water drank"
        case .stand: "of standing up and stretching"
        case .walk: "walked"
        case .breath: "of breathing exercise"
        }
    }
    
    var questValue: Int {
        switch self {
        case .drink: 300
        case .stand: 60
        case .walk: 20
        case .breath: 10
        }
    }
    
    static var allCategories: [HealthCategory] = [.drink, .stand, .walk, .breath]
    
    
    static func < (lhs: HealthCategory, rhs: HealthCategory) -> Bool {
        lhs.id < rhs.id
    }
}
