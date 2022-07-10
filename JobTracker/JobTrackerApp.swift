//
//  JobTrackerApp.swift
//  JobTracker
//
//  Created by Robson Tenório on 09/07/22.
//

import SwiftUI
import RealmSwift

let app: RealmSwift.App? = nil
    
@main
struct JobTrackerApp: SwiftUI.App {
    @ObservedResults(UserAccount.self) var users
    
    var body: some Scene {
        WindowGroup {
            NavigationView{
                if let user = users.first {
                    JobsListView(user: user)
                } else {
                    ProgressView()
                        .onAppear {
                            $users.append(UserAccount())
                        }
                }
            }
        }
    }
}
