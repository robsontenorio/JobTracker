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
    @Persisted var entries = RealmSwift.List<JobEntry>()
    
    convenience init(_ name: String){
        self.init()
        self.name = name
    }
}
