//
//  HomeView.swift
//  JobTracker
//
//  Created by Robson Tenório on 14/07/22.
//

import RealmSwift
import SwiftUI

struct HomeView: View {
    @ObservedRealmObject var user: UserAccount

    var body: some View {
        TabView {
            JobsListView(user: user)
                .tabItem {
                    Label("Jobs", systemImage: "briefcase")
                }

            ReportView()
                .tabItem {
                    Label("Reports", systemImage: "chart.pie")
                }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(user: RealmHelper.userAccount)
            .environment(\.realm, RealmHelper.preview)
    }
}
