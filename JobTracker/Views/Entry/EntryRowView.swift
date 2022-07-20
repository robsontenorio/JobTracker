//
//  JobEntryRowView.swift
//  JobTracker
//
//  Created by Robson Tenório on 10/07/22.
//

import RealmSwift
import SwiftUI

struct EntryRowView: View {
    @ObservedRealmObject var entry: Entry
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(entry.hours ?? 0) hours")
                    .bold()
                
                HStack {
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

struct EntryRowView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            EntryRowView(entry: RealmHelper.preview.objects(Job.self).first!.entries.first!)
                .padding()
                .background(.white)
        }
        .padding(10)
        .background(Color.gray.opacity(0.1))
    }
}
