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
            Image(systemName: "calendar")
            Text(entry.date.shortDate)
                .padding(.trailing)
                
            Image(systemName: "clock")
                .font(.caption)
                .foregroundColor(.gray)
                
            Text("\(entry.hours) hours")
                .font(.caption)
                .foregroundColor(.gray)
            
            Spacer()
                        
            Text(entry.earns.moneyLocalized)
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
