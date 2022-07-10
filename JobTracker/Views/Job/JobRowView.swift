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
        VStack(alignment: .leading){
            Text(job.name)
                .bold()
                
            
            JobProgressView(job: job)
        }
        
    }
}

struct JobRowView_Previews: PreviewProvider {
    static var previews: some View {
        JobRowView(job: RealmHelper.preview.objects(Job.self).first!)
    }
}
