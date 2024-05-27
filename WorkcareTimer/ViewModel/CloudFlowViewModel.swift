//
//  CloudFlowViewModel.swift
//  WorkcareTimer
//
//  Created by Elian Richard on 27/05/24.
//

import Foundation
import CloudKit

// AGGREGATE MODEL
@Observable class CloudFlowViewModel: ObservableObject {
    private var db = CKContainer(identifier: "iCloud.com.elian.WorkcareApp").privateCloudDatabase
    private var flowDictionary: [CKRecord.ID: FlowItem] = [:]
    
    var flows: [FlowItem] {
        flowDictionary.values.compactMap { $0 }
    }
    
    func addFlow(_ flowItem: FlowItem) async throws {
        do {
            let record = try await db.save(flowItem.record)
            guard let task = FlowItem(record: record) else { return }
            flowDictionary[task.recordId!] = task
        } catch {
            print (error)
        }
    }
    
    func resetFlow() async throws {
        flowDictionary = [:]
        do {
            let query = CKQuery(recordType: FlowRecordKeys.type.id, predicate: NSPredicate(value: true))
            query.sortDescriptors = [NSSortDescriptor(key: FlowRecordKeys.dateCompleted.id, ascending: false)]
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
    
    func populateFlows() async throws {
        do {
            let query = CKQuery(recordType: FlowRecordKeys.type.id, predicate: NSPredicate(value: true))
            query.sortDescriptors = [NSSortDescriptor(key: FlowRecordKeys.dateCompleted.id, ascending: false)]
            let result = try await db.records(matching: query)
            let records = result.matchResults.compactMap { try? $0.1.get() }
            
            records.forEach { record in
                flowDictionary[record.recordID] = FlowItem(record: record)
            }
        } catch {
            print(error)
        }
    }
}
