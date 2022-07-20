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
    @Persisted(originProperty: "jobs") var job: LinkingObjects<UserAccount>
    @Persisted var entries = RealmSwift.List<Entry>()

    convenience init(_ name: String) {
        self.init()
        self.name = name
    }

    var totalHours: Int {
        self.entries.sum(ofProperty: "hours") ?? 0
    }

    var totalEarns: Int {
        self.entries.sum(ofProperty: "earns") ?? 0
    }
}
