//
//  CloudKitModel.swift
//  WorkcareTimer
//
//  Created by Elian Richard on 27/05/24.
//

import Foundation
import CloudKit

// AGGREGATE MODEL
@Observable class CloudQuestViewModel: ObservableObject {
    private var db = CKContainer(identifier: "iCloud.com.elian.WorkcareApp").privateCloudDatabase
    private var questsDictionary: [CKRecord.ID: QuestItem] = [:]
    
    var quests: [QuestItem] {
        questsDictionary.values.compactMap { $0 }
    }
    
    func addQuest(_ questItem: QuestItem) async throws {
        do {
            let record = try await db.save(questItem.record)
            guard let task = QuestItem(record: record) else { return }
            questsDictionary[task.recordId!] = task
        } catch {
            print (error)
        }
    }
    
    func resetQuest() async throws {
        questsDictionary = [:]
        do {
            let query = CKQuery(recordType: QuestRecordKeys.type.id, predicate: NSPredicate(value: true))
            query.sortDescriptors = [NSSortDescriptor(key: QuestRecordKeys.dateCompleted.id, ascending: false)]
            let result = try await db.records(matching: query)
            let records = result.matchResults.compactMap { try? $0.1.get() }
            
            records.forEach { record in
                Task {
                    try await db.deleteRecord(withID: record.recordID)
                }
            }
        } catch {
            print(error)
        }
    }
    
    func populateQuests() async throws {
        do {
            let query = CKQuery(recordType: QuestRecordKeys.type.id, predicate: NSPredicate(value: true))
            query.sortDescriptors = [NSSortDescriptor(key: QuestRecordKeys.dateCompleted.id, ascending: false)]
            let result = try await db.records(matching: query)
            let records = result.matchResults.compactMap { try? $0.1.get() }
            
            records.forEach { record in
                questsDictionary[record.recordID] = QuestItem(record: record)
            }
        } catch {
            print(error)
        }
    }
}
