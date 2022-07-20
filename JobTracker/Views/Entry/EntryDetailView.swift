//
//  JobEntryDetailView.swift
//  JobTracker
//
//  Created by Robson Tenório on 09/07/22.
//

import RealmSwift
import SwiftUI

struct EntryDetailView: View {
    @ObservedRealmObject var entry: Entry
    
    var body: some View {
        List {
            // TODO: tudo editavel aqui
            
            Text("\(entry.hours ?? 0)")
            
            Text("\(entry.earns ?? 0)")
            
            Text(entry.startDate?.formatted(date: .long, time: .omitted) ?? "-")
            Text(entry.endDate?.formatted(date: .long, time: .omitted) ?? "-")
        }
        .navigationTitle("Entry")
    }
}
