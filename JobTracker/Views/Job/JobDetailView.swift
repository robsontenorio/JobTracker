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
    @State private var pricePerHour: Float = 0.0
    
    let currencyEditingFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
        
    var body: some View {
        Form {
            HStack {
                Image(systemName: "globe")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 30.0)
                    .padding(10)
                    .foregroundColor(.accentColor)
                
                TextField("Job Name", text: $name)
                    .font(.title2)
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
                LabeledContent("Price/Hour") {
                    TextField("--", value: $pricePerHour, formatter: currencyEditingFormatter)
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.decimalPad)
                }
            }
        }
        .navigationTitle("Job Settings")
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
            pricePerHour = job.pricePerHour
        }
    }
    
    private func save() {
        job.isFrozen ? update() : create()
        
        dismiss()
    }
    
    private func update() {
        let edit = job.thaw()!
        
        try! edit.realm!.write {
            edit.name = name
            edit.pricePerHour = pricePerHour
        }
    }
    
    private func create() {
        try? user.thaw()?.realm?.write {
            $user.jobs.append(Job(name, pricePerHour: pricePerHour))
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
