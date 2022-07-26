//
//  JobEntryListView.swift
//  JobTracker
//
//  Created by Robson Tenório on 09/07/22.
//

import RealmSwift
import SwiftUI

struct EntryListView: View {
    @ObservedRealmObject var user: UserAccount
    @ObservedRealmObject var job: Job

    @State private var addingEntry = false
    @State private var editingJob = false

    var body: some View {
        List {
            Section {
                JobProgressView(job: job)
                    .listRowInsets(EdgeInsets())
            }

            Section {
                Button(action: { addingEntry = true }) {
                    Label("Add entry", systemImage: "plus")
                }
                .sheet(isPresented: $addingEntry) {
                    NavigationView {
                        EntryDetailView(job: job, entry: Entry())
                    }
                }
            }

//            ForEach(job.entriesGroupedByMonth, id: \.self) { entries in
//                Section(entries[0].date.monthName) {
//            ForEach(entries) { entry in

            ForEach(job.entries.sorted(by: \.date)) { entry in
                NavigationLink(destination: EntryDetailView(job: job, entry: entry)) {
                    EntryRowView(entry: entry)
                }
            }
            .onDelete(perform: $job.entries.remove)
        }
        .navigationTitle(job.name)
        .toolbar {
            ToolbarItem {
                Button(action: { editingJob = true }) {
                    Image(systemName: "gearshape")
                }
                .sheet(isPresented: $editingJob) {
                    NavigationView {
                        JobDetailView(user: user, job: job)
                    }
                }
            }
        }
    }

    private func formatedDate(date: Date) -> any View {
        Text(date.formatted(date: .abbreviated, time: .omitted))
            .font(.caption)
            .foregroundColor(.gray)
    }
}

struct EntryListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            EntryListView(user: RealmHelper.userAccount, job: RealmHelper.jobs.first!)
                .environment(\.realm, RealmHelper.preview)
        }
    }
}
