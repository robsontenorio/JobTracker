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
    @State private var pricePerHour: Double? = 0.0
    @State private var currencySymbol: String = Locale.current.currencySymbol ?? "$"
    
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
                    .frame(height: 22)
                    .padding(8)
                    .foregroundColor(.accentColor)
                
                TextField("Job Name", text: $name)
                    .font(.title3)
                    .autocorrectionDisabled()
                    .bold()
            }
            
            Section("Settings") {
                LabeledContent("Price/Hour") {
                    CurrencyTextField("--", value: $pricePerHour, alwaysShowFractions: true, currencySymbol: "")
                        .multilineTextAlignment(.trailing)
                }
                
                LabeledContent("Currency Symbol") {
                    TextField("", text: $currencySymbol)
                        .multilineTextAlignment(.trailing)
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
            edit.pricePerHour = pricePerHour!
        }
    }
    
    private func create() {
        try? user.thaw()?.realm?.write {
            $user.jobs.append(Job(name, pricePerHour: pricePerHour!))
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
