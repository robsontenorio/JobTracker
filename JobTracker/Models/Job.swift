//
//  Job.swift
//  JobTracker
//
//  Created by Robson Tenório on 09/07/22.
//

import Foundation
import RealmSwift

final class Job: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var name: String
    @Persisted var pricePerHour: Double

    @Persisted var entries = RealmSwift.List<Entry>()
    @Persisted(originProperty: "jobs") var job: LinkingObjects<UserAccount>

    convenience init(_ name: String, pricePerHour: Double = 0.0) {
        self.init()
        self.name = name
        self.pricePerHour = pricePerHour
    }

    var totalHours: Int {
        self.entries.sum(ofProperty: "hours") ?? 0
    }

    var totalEarns: Double {
        self.entries.sum(ofProperty: "earns") ?? 0
    }

    // TODO: consider SAME DAY ENTRIES
    var totalDays: Int {
        return self.entries.count
    }

    var entriesGroupedByMonth: [[Entry]] {
        let sortedEntries = self.entries.sorted(byKeyPath: "date", ascending: false)
        
        guard !sortedEntries.isEmpty else { return [] }
        let dictionaryByMonth = Dictionary(grouping: sortedEntries, by: { $0.date.monthNumber })
        let months = Array(1 ... 12) // rotate this array if you want to go from October to September
        return months.compactMap { dictionaryByMonth[$0] }
    }

}
