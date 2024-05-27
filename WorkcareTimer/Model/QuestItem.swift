//
//  QuestItem.swift
//  WorkcareTimer
//
//  Created by Elian Richard on 27/05/24.
//

import Foundation
import CloudKit

enum QuestRecordKeys: String {
    case type
    case category
    case dateCompleted
    case value
    
    var id: String {
        switch self {
        case .type: "QuestType"
        case .category: "category"
        case .dateCompleted: "dateCompleted"
        case .value: "value"
        }
    }
}

struct QuestItem {
    var recordId: CKRecord.ID?
    let category: String
    let dateCompleted: Date
    let value: Int
}

extension QuestItem {
    init?(record: CKRecord) {
        guard let category = record[QuestRecordKeys.category.id] as? String,
              let dateCompleted = record[QuestRecordKeys.dateCompleted.id] as? Date,
              let value = record[QuestRecordKeys.value.id] as? Int else {
            return nil
        }
        self.init(recordId: record.recordID, category: category, dateCompleted: dateCompleted, value: value)
    }
}

extension QuestItem {
    var record: CKRecord {
        let record = CKRecord(recordType: QuestRecordKeys.type.id)
        record[QuestRecordKeys.category.id] = category
        record[QuestRecordKeys.dateCompleted.id] = dateCompleted
        record[QuestRecordKeys.value.id] = value
        return record
    }
}
