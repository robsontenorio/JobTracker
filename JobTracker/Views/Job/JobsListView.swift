//
//  JobsList.swift
//  JobTracker
//
//  Created by Robson Tenório on 09/07/22.
//

import SwiftUI
import RealmSwift

struct JobsListView: View {
    
    @ObservedRealmObject var user: UserAccount
    @State private var addingJob = false
    
    var body: some View {
        List{
            ForEach(user.jobs){ job in
                NavigationLink(destination: JobEntryListView(job: job)){
                    JobRowView(job: job)
                }
            }
            .onDelete(perform: $user.jobs.remove)
            .onMove(perform: $user.jobs.move)
        }
        .navigationTitle("Jobs")
        .toolbar{            
            ToolbarItem(placement: .navigationBarTrailing){
                Button(action: { addingJob = true }) {
                    Image(systemName: "plus")
                }
                .sheet(isPresented: $addingJob){
                    NavigationView{
                        AddJobView(user: user)
                    }                    
                }
            }
        }
    }
}


struct JobsListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            JobsListView(user: RealmHelper.userAccount)
                .environment(\.realm, RealmHelper.preview)
        }
    }
}
