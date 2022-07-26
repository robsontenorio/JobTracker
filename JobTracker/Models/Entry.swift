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
    @Persisted var date: Date
    @Persisted var hours: Int
    @Persisted var earns: Double

    @Persisted(originProperty: "entries") var job: LinkingObjects<Job>

    convenience init(_ hours: Int, date: Date = Date(), earns: Double = 0.0) {
        self.init()
        self.hours = hours
        self.date = date
        self.earns = earns
    }
    
    var month: Int{
        self.date.monthNumber
    }
}
