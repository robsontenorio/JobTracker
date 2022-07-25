//
//  AddJobEntryView.swift
//  JobTracker
//
//  Created by Robson Tenório on 09/07/22.
//

import RealmSwift
import SwiftUI

struct EntryDetailView: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedRealmObject var job: Job
    @ObservedRealmObject var entry: Entry
    
    @State private var hours: Int = 0
    @State private var date = Date()
    @State private var showDatePicker = false
    
    private var earns: Float {
        Float(hours) * job.pricePerHour
    }
    
    var body: some View {
        List {
            Section(footer: Text("Total = (worked hours) * (price per hour)")) {
                Text(earns.moneyLocalized)
                    .font(.title)
                    .bold()
                    .foregroundColor(.green)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(5)
            }

            Section {
                LabeledContent {
                    Text(date.formatted(.dateTime.day().month().year()))
                          
                } label: {
                    Label("Date", systemImage: "calendar")
                }
                .onTapGesture {
                    showDatePicker = true
                }
               
                LabeledContent {
                    Picker("", selection: $hours) {
                        ForEach(0 ..< 25, id: \.self) {
                            Text("\($0)")
                        }
                    }
                    
                } label: {
                    Label("Worked hours", systemImage: "clock")
                }
            }
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
        .onAppear {
            hours = entry.hours
            date = entry.date
        }
        .sheet(isPresented: $showDatePicker) {
            DatePicker("", selection: $date, displayedComponents: .date)
                .datePickerStyle(.graphical)
                .presentationDetents([.medium, .large])
                .onChange(of: date) { _ in
                    showDatePicker = false
                }
                .padding()
        }
    }
    
    private func save() {
        entry.isFrozen ? update() : create()
        
        dismiss()
    }
    
    private func update() {
        let edit = entry.thaw()!
        
        try! edit.realm!.write {
            edit.date = date
            edit.hours = hours
            edit.earns = earns
        }
    }
    
    private func create() {
        try? job.thaw()?.realm?.write {
            $job.entries.append(Entry(hours, date: date, earns: earns))
        }
    }
}

struct EntryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            EntryDetailView(job: RealmHelper.jobs.first!, entry: Entry())
        }
    }
}
