//
//  WorkFlow.swift
//  WorkcareTimer
//
//  Created by Elian Richard on 21/05/24.
//

import Foundation

enum WorkFlowType: Identifiable, CaseIterable, Hashable, Codable {
    case focus
    case short
    case long
    
    var id: String {
        switch self {
        case .focus: "focus"
        case .short: "short"
        case .long: "long"
        }
    }
    
    var initialIcon: String {
        switch self {
        case .focus: "circle.dashed"
        case .short: "drop.circle"
        case .long: "tree.circle"
        }
    }
    
    var iconSize: CGFloat {
        switch self {
        case .focus: 20
        case .short: 15
        case .long: 20
        }
    }
    
    var doneIcon: String {
        switch self {
        case .focus: "checkmark.circle.fill"
        case .short: "checkmark.circle.fill"
        case .long: "checkmark.circle.fill"
        }
    }
    
    var statisticDescription: String {
        switch self {
        case .focus: "of focus period"
        case .short: "of short break period"
        case .long: "of long break period"
        }
    }
    
    var achievementDescription: String {
        switch self {
        case .focus: "Acquire the total of {value} flows of focus period"
        case .short: "Acquire the total of {value} flows of short break period"
        case .long: "Acquire the total of {value} flows of long break period"
        }
    }
    
    static var flowUnit: String = "flows"
    
    static var allFlows: [WorkFlowType] = [.focus, .short, .long]
}

// Need to create new struct because the ID on each array element sould be different
struct CreateWorkFlowType: Identifiable {
    var id: UUID
    var type: WorkFlowType
    
    init(_ workflow: WorkFlowType) {
        self.id = UUID()
        self.type = workflow
    }
}

struct WorkFlowValue {
    var workflows: [CreateWorkFlowType] = [
        CreateWorkFlowType(.focus),
        CreateWorkFlowType(.short),
        CreateWorkFlowType(.focus),
        CreateWorkFlowType(.short),
        CreateWorkFlowType(.focus),
        CreateWorkFlowType(.short),
        CreateWorkFlowType(.focus),
        CreateWorkFlowType(.long),
    ]
    var timer: [WorkFlowType: Int] = [
        //        .focus: 60 * 25,
        //        .short: 60 * 5,
        //        .long: 60 * 10,
        .focus: 7,
        .short: 5,
        .long: 6,
    ]
}
