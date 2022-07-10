//
//  Job.swift
//  JobTracker
//
//  Created by Robson Tenório on 09/07/22.
//

import Foundation
import RealmSwift

final class UserAccount: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var jobs = RealmSwift.List<Job>()
}
