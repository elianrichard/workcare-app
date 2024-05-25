//
//  MenuSection.swift
//  WorkcareTimer
//
//  Created by Elian Richard on 21/05/24.
//

import Foundation

enum MenuSection: Identifiable, CaseIterable, Hashable {
    case timer
    case achievement
    case statistic
    case store
    case profile
    
    var id: String {
        switch self {
        case .timer:
            "timer"
        case .achievement:
            "achievement"
        case .statistic:
            "statistic"
        case .store:
            "store"
        case .profile:
            "profile"
        }
    }
    
    var displayName: String {
        switch self {
        case .timer:
            "Timer"
        case .achievement:
            "Achievement"
        case .statistic:
            "Statistic"
        case .store:
            "Store"
        case .profile:
            "Profile"
        }
    }
    
    var iconName: String {
        switch self {
        case .timer:
            "Timer"
        case .achievement:
            "Achievement"
        case .statistic:
            "Statistic"
        case .store:
            "Store"
        case .profile:
            "Profile"
        }
    }
    
    static var allCases: [MenuSection] {
        [.timer, .achievement, .statistic, .store, .profile]
    }
    
    //    This == func will override the == operator when handling or comparing TaskSection obj struct,
    //    so it will compore the id instead of the struct itself
    static func == (lhs: MenuSection, rhs: MenuSection) -> Bool {
        lhs.id == rhs.id
    }
}
