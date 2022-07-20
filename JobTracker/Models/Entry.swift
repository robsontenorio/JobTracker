//
//  JobEntry.swift
//  JobTracker
//
//  Created by Robson Tenório on 09/07/22.
//

import Foundation
import RealmSwift

class Entry: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var startDate: Date?
    @Persisted var endDate: Date?
    @Persisted var hours: Int?
    @Persisted var earns: Int?

    @Persisted(originProperty: "entries") var job: LinkingObjects<Job>

    convenience init(_ hours: Int, startDate: Date? = nil, endDate: Date? = nil, earns: Int? = nil) {
        self.init()
        self.hours = hours
        self.startDate = startDate
        self.endDate = endDate
        self.earns = earns
    }
}
