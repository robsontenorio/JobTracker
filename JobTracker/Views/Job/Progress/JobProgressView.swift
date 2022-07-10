//
//  JobProgressView.swift
//  JobTracker
//
//  Created by Robson Tenório on 10/07/22.
//

import SwiftUI
import RealmSwift

struct JobProgressView: View {
    @ObservedRealmObject var job: Job
    
    var body: some View {
        HStack{
            Card(total: job.entries.count, caption: "entries")
            Card(total: job.totalHours, caption: "Hours")
            Card(total: job.totalEarns, caption: "earns", metric: "$")
        }
    }
}

struct Card: View {
    var total: Int
    var caption: String
    var metric: String = ""
    
    var body: some View{
        VStack{
            Text("\(metric) \(total)")
                .bold()
            
            Text(caption)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 5)
                .stroke(lineWidth: 1)
                .foregroundColor(.gray)
        )
    }
}


struct JobProgressView_Previews: PreviewProvider {
    static var previews: some View {
        JobProgressView(job: RealmHelper.preview.objects(Job.self).first!)
    }
}
