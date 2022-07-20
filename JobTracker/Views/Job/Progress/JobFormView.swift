//
//  JobFormView.swift
//  JobTracker
//
//  Created by Robson Tenório on 18/07/22.
//

import RealmSwift
import SwiftUI

struct JobFormView: View {
    @Binding var job: Job
    
    var currencies = ["R$", "$", "£"]
        
    var body: some View {
        Form {
            VStack {
                Image(systemName: "globe")
                    .resizable()
                    .frame(width: 56.0, height: 56.0)
                    .padding()
                    .foregroundColor(.cyan)
                
                TextField("Job Name", text: $job.name)
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
                
//                LabeledContent("Price/Hour"){
//                    TextField("--", value: $pricePerHour, format: .number)
//                        .multilineTextAlignment(.trailing)
//                }
            }
        }
//        .toolbar{
//            ToolbarItem{
//                Button("OK"){
//                    save()
//                }
//                .disabled(job.name == "")
//            }
//        }
    }
    
    private func save() {
//        try? user.thaw()?.realm?.write {
//            $user.jobs.append(Job(name))
//        }
//
//        dismiss()
        
//        let jobEdit = job.thaw()!
//
//        try! jobEdit.realm!.write {
//            jobEdit.name = job.name
//        }
    }
}

struct JobFormView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
//            JobFormView(user: RealmHelper.userAccount)
        }
    }
}
