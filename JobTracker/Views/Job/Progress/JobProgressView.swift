//
//  JobProgressView.swift
//  JobTracker
//
//  Created by Robson Tenório on 10/07/22.
//

import RealmSwift
import SwiftUI

struct JobProgressView: View {
    @ObservedRealmObject var job: Job

    var body: some View {
        HStack {
            Card(total: job.entries.count, caption: "entries")
            Card(total: job.totalHours, caption: "Hours")
            Card(total: job.totalEarns, caption: "total", metric: "$")
        }
    }
}

struct Card: View {
    var total: Int
    var caption: String
    var metric: String = ""

    var body: some View {
        VStack(alignment: .leading) {
            Text("\(metric)\(total)")
                .bold()

            Text(caption)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding()
        .background(.white)
        .overlay(
            RoundedRectangle(cornerRadius: 5)
                .stroke(lineWidth: 0.2)
                .foregroundColor(.gray)
        )
    }
}

struct JobProgressView_Previews: PreviewProvider {
    static var previews: some View {
        JobProgressView(job: RealmHelper.preview.objects(Job.self).first!)
            .padding(40)
            .background(Color.gray.opacity(0.1))
    }
}
