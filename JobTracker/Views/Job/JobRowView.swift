//
//  JobRow.swift
//  JobTracker
//
//  Created by Robson Tenório on 09/07/22.
//

import RealmSwift
import SwiftUI

struct JobRowView: View {
    @ObservedRealmObject var job: Job
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(job.name)
                    .bold()
                    .padding(.bottom, 5)
                    
                HStack {
                    Image(systemName: "calendar")
                    Text("\(job.entries.count) days")
                        
                    Image(systemName: "clock")
                    Text("\(job.totalHours) hours")
                }
                .font(.caption)
                .foregroundColor(.secondary)
            }
                
            Spacer()
                
            Text(job.totalEarns.money())
                .foregroundColor(.green)
        }
    }
}

struct JobRowView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            JobRowView(job: RealmHelper.preview.objects(Job.self).first!)
                .padding()
                .background(.white)
        }
        .padding(30)
        .background(Color.gray.opacity(0.1))
    }
}
