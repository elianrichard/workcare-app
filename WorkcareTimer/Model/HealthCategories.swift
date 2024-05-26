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
    case breathe
    
    var id: String {
        switch self {
        case .drink: "drink"
        case .stand: "stand"
        case .walk: "walk"
        case .breathe: "breathe"
        }
    }
    
    var questText: String {
        switch self {
        case .drink: "Drink 300 mL of water"
        case .stand: "Stand up & stretch for 60 seconds"
        case .walk: "Walk 20 steps"
        case .breathe: "Inhale and Exhale breath for 10 seconds"
        }
    }
    
    var questUnit: String {
        switch self {
        case .drink: "L"
        case .stand: "s"
        case .walk: "steps"
        case .breathe: "s"
        }
    }
    
    var questUnitDivider: Int {
        switch self {
        case .drink: 1000
        case .stand: 1
        case .walk: 1
        case .breathe: 1
        }
    }
    
    var recapText: String {
        switch self {
        case .drink: "of water drank"
        case .stand: "of standing up"
        case .walk: "walked"
        case .breathe: "of breathing exercise"
        }
    }
    
    var questValue: Int {
        switch self {
        case .drink: 300
        case .stand: 60
        case .walk: 20
        case .breathe: 10
        }
    }
    
    var achievementDescription: String {
        switch self {
        case .drink: "Acquire the total of {value} L of water drank"
        case .stand: "Acquire the total of {value} seconds of standing"
        case .walk: "Acquire the total of {value} steps of walking"
        case .breathe: "Acquire the total of {value} seconds of breathing exercise"
        }
    }
    
    static var allCategories: [HealthCategory] = [.drink, .stand, .walk, .breathe]
}
