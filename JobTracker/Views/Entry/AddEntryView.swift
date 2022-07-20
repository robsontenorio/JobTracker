//
//  AddJobEntryView.swift
//  JobTracker
//
//  Created by Robson Tenório on 09/07/22.
//

import RealmSwift
import SwiftUI

struct AddEntryView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedRealmObject var job: Job
    
    @State private var hours: Int? = nil
    @State private var earns: Int? = nil
    @State private var startDate = Date()
    @State private var endDate = Date()
    
    var body: some View {
        ScrollView {
            HStack {
                VStack {
                    TextField("0", value: $hours, format: .number)
                        .bold()
                        .font(.title2)
                        .padding()
                        .background()
                        .multilineTextAlignment(.center)
                    
                    Text("hours")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .frame(width: 100, height: 100)
                .border(.gray)
                
                VStack {
                    TextField("$", value: $earns, format: .number)
                        .bold()
                        .font(.title2)
                        .padding()
                        .background()
                        .multilineTextAlignment(.center)
                    
                    Text("earned")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .frame(width: 100, height: 100)
                .border(.gray)
            }
            
            DatePicker(selection: $startDate, displayedComponents: .date) {
                Text("Select a date")
            }
            
            DatePicker(selection: $endDate, displayedComponents: .date) {
                Text("Select a date")
            }
            
            //            Spacer()
            
            //            Form{
            //                HStack{
            //                    Text("Hours")
            //                    Spacer()
            //                    TextField("0 hours", value: $hours, format: .number)
            //                        .multilineTextAlignment(.trailing)
            //                }
            //
            //                HStack{
            //                    Text("Earns $")
            //                    Spacer()
            //                    TextField("0,00", value: $earns, format: .number)
            //                        .multilineTextAlignment(.trailing)
            //                }
            //
            //
            //
            //
            //
            //                DatePicker(selection: $startDate, displayedComponents: .date) {
            //                    Text("Select a date")
            //                }
            //
            //                DatePicker(selection: $endDate, displayedComponents: .date) {
            //                    Text("Select a date")
            //                }
            //
            //            }
        }
        .navigationTitle("Entry")
        .toolbar {
            ToolbarItem {
                Button("OK") {
                    save()
                }
                .disabled(hours == 0)
            }
        }
    }
    
    private func save() {
        try? job.thaw()?.realm?.write {
            $job.entries.append(Entry(hours!, startDate: startDate, endDate: endDate, earns: earns!))
        }
        
        dismiss()
    }
}

struct AddEntryView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddEntryView(job: RealmHelper.jobs.first!)
        }
    }
}
