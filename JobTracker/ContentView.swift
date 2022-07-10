//
//  ContentView.swift
//  JobTracker
//
//  Created by Robson Tenório on 09/07/22.
//

import SwiftUI
import RealmSwift


struct ContentView: View {
    @ObservedResults(UserAccount.self) var users
    
    var body: some View {
        
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.realm, RealmHelper.preview)
    }
}



