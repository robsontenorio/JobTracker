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
                HStack{
                    VStack{
                        Text("\(job.entries.count)")
                            .bold()
                        Text("entries")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    
                    VStack{
                        Text("\(job.entries.sum(ofProperty: "hours") ?? 0)")
                            .bold()
                        Text("hours")
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                    }
                    
                    VStack{
                        Text("$ \(job.entries.sum(ofProperty: "earns") ?? 0)")
                            .bold()
                            .foregroundColor(.green)
                        
                        Text("earned")
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                    }
                }
            }
            
            Section("Entries"){
                ForEach(job.entries){ entry in
                    NavigationLink(destination: JobEntryDetailView(entry: entry)){
                        HStack{
                            VStack(alignment: .leading){
                                Text("\(entry.hours ?? 0) hours")
                                    .bold()
                                    
                                
                    
                                HStack{
                                    Text(entry.startDate?.formatted(date: .abbreviated , time: .omitted) ?? "-")
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
}

struct JobEntryListView_Previews: PreviewProvider {
    static var previews: some View {
        JobEntryListView(job: RealmHelper.jobs.first!)
            .environment(\.realm, RealmHelper.preview)
    }
}
