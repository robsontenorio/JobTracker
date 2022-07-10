//
//  AddJobEntryView.swift
//  JobTracker
//
//  Created by Robson Tenório on 09/07/22.
//

import SwiftUI
import RealmSwift

struct AddJobEntryView: View {
    @ObservedRealmObject var job: Job
    @Environment(\.dismiss) var dismiss
    
    @State private var hours: Int? = nil
    @State private var earns: Int? = nil
    @State private var startDate = Date()
    @State private var endDate = Date()
    
    var body: some View {
        List{
            TextField("Total", value: $hours, format: .number)
            
            TextField("Earns", value: $earns, format: .number)
            
            DatePicker(selection: $startDate, displayedComponents: .date) {
                Text("Select a date")
            }
            
            DatePicker(selection: $endDate, displayedComponents: .date) {
                Text("Select a date")
            }
            
        }
        .navigationTitle("Add")
        .toolbar{
            ToolbarItem{
                Button("OK"){
                    save()
                }
                .disabled(hours == 0)
            }
        }
        
    }
    
    private func save(){
        try? job.thaw()?.realm?.write {
            $job.entries.append(JobEntry(hours!, startDate: startDate, endDate: endDate, earns: earns!))
        }
        
        dismiss()
    }
}
