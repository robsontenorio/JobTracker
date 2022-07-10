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
    var body: some Scene {
        WindowGroup {
            NavigationView{
                ContentView()
            }
        }
    }
}
