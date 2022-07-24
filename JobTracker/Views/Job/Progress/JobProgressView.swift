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
        VStack {
            Text(job.totalEarns.money())
                .font(.title2)
                .bold()
                .padding()

            HStack {
                Label("\(job.totalDays) days", systemImage: "calendar")

                Spacer()

                Label("\(job.totalHours) hours", systemImage: "clock")
            }
        }
        .foregroundColor(.white)
        .listRowInsets(EdgeInsets())
        .padding()
        .background(
            LinearGradient(
                colors: [.blue,  .purple, .purple, .blue, .purple],
                startPoint: .bottomLeading,
                endPoint: .topTrailing
            )
        )
    }
}

struct JobProgressView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            JobProgressView(job: RealmHelper.preview.objects(Job.self).first!)
        }
    }
}
