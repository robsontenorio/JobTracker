//
//  RealmHelper.swift
//  JobTracker
//
//  Created by Robson Tenório on 10/07/22.
//

import Foundation
import RealmSwift

class RealmHelper{
    
    static let userAccount = UserAccount()
    static let jobs = [Job("Job 1"), Job("Job 2"), Job("Job 3")]
    static let job1Entries = [JobEntry(12), JobEntry(55)]
    
    
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
                    
                    let job1 = jobs.first
                    
                    print(job1?.name)
                    
                    job1?.entries.append(objectsIn: job1Entries)
                }
                
                return realm
            }
        } catch let error {
            fatalError("Can't bootstrap item data: \(error.localizedDescription)")
        }
    }
}
