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
            Section("Progress") {
                JobProgressView(job: job)
                    .listRowBackground(Color.clear)
            }
            
            Section("Entries") {
                ForEach(job.entries) { entry in
                    NavigationLink(destination: EntryDetailView(entry: entry)) {
                        EntryRowView(entry: entry)
                    }
                }
                .onDelete(perform: $job.entries.remove)
                .onMove(perform: $job.entries.move)
            }
        }
        .navigationTitle(job.name)
        .toolbar {
            ToolbarTitleMenu {
                Button {} label: {
                    Label("Settings", systemImage: "gearshape")
                }
                
                //                NavigationLink(destination: JobDetailView(job: job)){
                //                    Text("Edit")
                //                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack {
                    //                    NavigationLink(destination: JobDetailView(job: job)){
                    //                        Text("Edit")
                    //                    }
                    
                    Button(action: { editingJob = true }) {
                        Text("Edit")
                    }
                    .sheet(isPresented: $editingJob) {
                        NavigationView {
                            JobDetailView(user: user, job: job)
                        }
                    }
                    
                    Button(action: { addingEntry = true }) {
                        Image(systemName: "plus")
                    }
                    .sheet(isPresented: $addingEntry) {
                        NavigationView {
                            AddEntryView(job: job)                         
                        }
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
