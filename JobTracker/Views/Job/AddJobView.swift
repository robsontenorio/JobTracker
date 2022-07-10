//
//  AddJobView.swift
//  JobTracker
//
//  Created by Robson Tenório on 09/07/22.
//

import SwiftUI
import RealmSwift

struct AddJobView: View {
    @ObservedRealmObject var user: UserAccount
    @Environment(\.dismiss) var dismiss
    @State private var name = ""
    
    var body: some View {
        List{
            TextField("Name", text: $name)
        }
        .navigationTitle("Add")
        .toolbar{
            ToolbarItem{
                Button("OK"){
                    save()
                }
                .disabled(name == "")
            }
        }
    }
    
    
    private func save(){
        try? user.thaw()?.realm?.write {
            $user.jobs.append(Job(name))
        }
        
        dismiss()
    }
}
