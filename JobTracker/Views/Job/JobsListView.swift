//
//  JobsList.swift
//  JobTracker
//
//  Created by Robson Tenório on 09/07/22.
//

import RealmSwift
import SwiftUI

struct JobsListView: View {
    @ObservedRealmObject var user: UserAccount
    @State private var addingJob = false

    var body: some View {
        NavigationView {
            List {
                ForEach(user.jobs) { job in
                    NavigationLink(destination: EntryListView(user: user, job: job)) {
                        JobRowView(job: job)
                            .padding(.vertical)
                    }
                }
                .onDelete(perform: $user.jobs.remove)
                .onMove(perform: $user.jobs.move)
            }
            .navigationTitle("Jobs")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { addingJob = true }) {
                        Image(systemName: "plus")
                    }
                    .sheet(isPresented: $addingJob) {
                        NavigationView {
                            JobDetailView(user: user, job: Job(""))
                        }
                    }
                }
            }
        }
    }
}

struct JobsListView_Previews: PreviewProvider {
    static var previews: some View {
        JobsListView(user: RealmHelper.userAccount)
            .environment(\.realm, RealmHelper.preview)
    }
}
