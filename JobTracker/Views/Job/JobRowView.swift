//
//  JobRow.swift
//  JobTracker
//
//  Created by Robson Tenório on 09/07/22.
//

import SwiftUI
import RealmSwift

struct JobRowView: View {
    @ObservedRealmObject var job: Job
    
    var body: some View {
        HStack{
            Text(job.name)
            Spacer()
            Text("\(job.entries.count)")
                .font(.caption)
        }
        
    }
}

struct JobRowView_Previews: PreviewProvider {
    static var previews: some View {
        JobRowView(job: RealmHelper.preview.objects(Job.self).first!)
    }
}
