//
//  FlowItem.swift
//  WorkcareTimer
//
//  Created by Elian Richard on 27/05/24.
//

import Foundation
import CloudKit

enum FlowRecordKeys: String {
    case type
    case category
    case dateCompleted
    
    var id: String {
        switch self {
        case .type: "FlowType"
        case .category: "category"
        case .dateCompleted: "dateCompleted"
        }
    }
}

struct FlowItem {
    var recordId: CKRecord.ID?
    let category: String
    let dateCompleted: Date
}

extension FlowItem {
    init?(record: CKRecord) {
        guard let category = record[FlowRecordKeys.category.id] as? String,
              let dateCompleted = record[FlowRecordKeys.dateCompleted.id] as? Date else {
            return nil
        }
        self.init(recordId: record.recordID, category: category, dateCompleted: dateCompleted)
    }
}

extension FlowItem {
    var record: CKRecord {
        let record = CKRecord(recordType: FlowRecordKeys.type.id)
        record[FlowRecordKeys.category.id] = category
        record[FlowRecordKeys.dateCompleted.id] = dateCompleted
        return record
    }
}
