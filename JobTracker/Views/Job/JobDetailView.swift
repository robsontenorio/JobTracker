//
//  JobDetail.swift
//  JobTracker
//
//  Created by Robson Tenório on 09/07/22.
//

import SwiftUI
import RealmSwift

struct JobDetailView: View {
    @ObservedRealmObject var job: Job
    @Environment(\.dismiss) var dismiss

    @State private var name = ""
        
    var body: some View {
        List{
            TextField("name", text: $name)
        }
        .navigationTitle(job.name)
        .onAppear{
            name = job.name
        }
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing){
                Button("OK"){
                  save()
                }
                .disabled(name == "")
            }
        }
    }
    
    private func save(){
        let jobEdit = job.thaw()!
                                                
        try! jobEdit.realm!.write {
            jobEdit.name = name
        }
        
        dismiss()
    }
}

struct JobDetailView_Previews: PreviewProvider {

    static var previews: some View {
        NavigationView{
            JobDetailView(job: RealmHelper.preview.objects(Job.self).first!)
        }
    }
}
