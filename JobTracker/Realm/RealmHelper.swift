//
//  RealmHelper.swift
//  JobTracker
//
//  Created by Robson Tenório on 10/07/22.
//

import Foundation
import RealmSwift

class RealmHelper {
    static let userAccount = UserAccount()
    static let jobs = [Job("Job 1", pricePerHour: 2.00), Job("Job 2", pricePerHour: 4.50), Job("Job 3", pricePerHour: 10.00)]
    static let job1Entries = [Entry(12, date: Date(), earns: 44.00), Entry(8, date: Date(), earns: 981.24)]

    static var preview: Realm {
        var realm: Realm
        let config = Realm.Configuration(inMemoryIdentifier: "previewRealm")

        do {
            realm = try Realm(configuration: config)

            if realm.objects(UserAccount.self).count == 1 {
                return realm
            } else {
                try realm.write {
                    realm.add(userAccount)
                    userAccount.jobs.append(objectsIn: jobs)
                    jobs.first!.entries.append(objectsIn: job1Entries)
                }

                return realm
            }
        } catch {
            fatalError("Can't bootstrap item data: \(error.localizedDescription)")
        }
    }
}
