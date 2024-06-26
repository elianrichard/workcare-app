//
//  MenuSection.swift
//  WorkcareTimer
//
//  Created by Elian Richard on 21/05/24.
//

import Foundation
import SwiftUI

enum MenuItems: Identifiable, CaseIterable, Hashable {
    case home
    case achievement
    case statistic
    
    var id: String {
        switch self {
        case .home:
            "home"
        case .achievement:
            "achievement"
        case .statistic:
            "statistic"
        }
    }
    
    var displayName: String {
        switch self {
        case .home:
            "Home"
        case .achievement:
            "Achievements"
        case .statistic:
            "Statistics"
        }
    }
    
    var iconName: String {
        switch self {
        case .home:
            "house.fill"
        case .achievement:
            "trophy.fill"
        case .statistic:
            "chart.bar.fill"
        }
    }
    
    var iconSize: CGFloat {
        switch self {
        case .home:
            12
        case .achievement:
            12
        case .statistic:
            13
        }
    }
    
    var bgImage: ImageResource {
        switch self {
        case .home:
                .homeBg
        case .achievement:
                .achievementBg
        case .statistic:
                .statisticBg
        }
    }

    static var allCases: [MenuItems] {
        [.home, .achievement, .statistic]
    }

    //    This == func will override the == operator when handling or comparing TaskSection obj struct,
    //    so it will compore the id instead of the struct itself
    static func == (lhs: MenuItems, rhs: MenuItems) -> Bool {
        lhs.id == rhs.id
    }
    static func < (lhs: MenuItems, rhs: MenuItems) -> Bool {
        lhs.id < rhs.id
    }
    static func > (lhs: MenuItems, rhs: MenuItems) -> Bool {
        lhs.id > rhs.id
    }
}
