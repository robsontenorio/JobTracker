//
//  JobEntryListView.swift
//  JobTracker
//
//  Created by Robson Tenório on 09/07/22.
//

import SwiftUI
import RealmSwift

struct JobEntryListView: View {
    
    @ObservedRealmObject var job: Job
    @State private var addingEntry = false
    
    var body: some View {
        List{
            
            Section("Progress"){
                JobProgressView(job: job)
            }
            
            Section("Entries"){
                ForEach(job.entries){ entry in
                    NavigationLink(destination: JobEntryDetailView(entry: entry)){
                        HStack{
                            VStack(alignment: .leading){
                                Text("\(entry.hours ?? 0) hours")
                                    .bold()
                                    
                                
                               
                                
                                HStack{
                                   
                                    Text(entry.startDate?.formatted(date: .abbreviated, time: .omitted) ?? "-")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                    
                                    Text(" - ")
                                    
                                    Text(entry.endDate?.formatted(date: .abbreviated, time: .omitted) ?? "-")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                    
                                }
                                
                            }

                            Spacer()
                            
                            Text("$ \(entry.earns ?? 0)")
                                .bold()
                                .foregroundColor(.green)
                            
                        }

                    }
                }
                .onDelete(perform: $job.entries.remove)
                .onMove(perform: $job.entries.move)
            }
            
            
        }
        .navigationTitle(job.name)
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing){
                
                HStack{
                    NavigationLink(destination: JobDetailView(job: job)){
                        Text("Edit")
                    }
                    
                    Button(action: { addingEntry = true }) {
                        Image(systemName: "plus")
                    }
                    .sheet(isPresented: $addingEntry){
                        NavigationView{
                            AddJobEntryView(job: job)
                            EmptyView()
                        }
                    }
                }
            }
            
        }
    }
    
    private func formatedDate(date: Date) -> any View{
            
        Text(date.formatted(date: .abbreviated , time: .omitted))
            .font(.caption)
            .foregroundColor(.gray)
    }
}

struct JobEntryListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            JobEntryListView(job: RealmHelper.jobs.first!)
                .environment(\.realm, RealmHelper.preview)
        }
    }
}
