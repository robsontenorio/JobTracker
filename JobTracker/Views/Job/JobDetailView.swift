//
//  JobDetail.swift
//  JobTracker
//
//  Created by Robson Tenório on 09/07/22.
//

import RealmSwift
import SwiftUI

struct JobDetailView: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedRealmObject var user: UserAccount
    @ObservedRealmObject var job: Job
    
    @State private var name: String = ""
    
    private var isEditing: Bool {
        job.name == "" ? false : true
    }
        
    var body: some View {
        Form {
            VStack {
                Image(systemName: "globe")
                    .resizable()
                    .frame(width: 56.0, height: 56.0)
                    .padding()
                    .foregroundColor(.cyan)
                
                TextField("Job Name", text: $name)
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .autocorrectionDisabled()
                    .bold()
            }
            
            Section("Settings") {
//                Picker(selection: $currencyIndex, label: Text("Currency")) {
//                    ForEach(0 ..< currencies.count) {
//                        Text(self.currencies[$0])
//                    }
//                }
//
//                LabeledContent("Price/Hour") {
//                    TextField("--", value: $pricePerHour, format: .number)
//                        .multilineTextAlignment(.trailing)
//                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("OK") {
                    save()
                }
                .disabled(name == "")
            }
        }
        .onAppear {
            name = job.name
        }
    }
    
    private func save() {
        isEditing ? update() : create()
        
        dismiss()
    }
    
    private func update() {
        let edit = job.thaw()!
        
        try! edit.realm!.write {
            edit.name = name
        }
    }
    
    private func create() {
        try? user.thaw()?.realm?.write {
            $user.jobs.append(Job(name))
        }
    }
}

struct JobDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            JobDetailView(user: RealmHelper.userAccount, job: RealmHelper.preview.objects(Job.self).first!)
        }
    }
}
