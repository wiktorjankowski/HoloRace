//
//  AccountView.swift
//  HoloRace
//
//  Created by Wiktor Jankowski on 27/04/2022.
//

import SwiftUI
import Firebase
import MessageUI

struct AccountView: View {
    @State var signOutProcessing = false
    @State var isDeleted = false
    @Environment(\.dismiss) var dismiss
    @AppStorage("isLogged") var isLogged = false
    @AppStorage("isLiteMode") var isLiteMode = true
    var body: some View {
        NavigationView {
            List {
                profile
                menu
                Section {
                                   Toggle(isOn: $isLiteMode) {
                                       Label("Lite Mode", systemImage: isLiteMode ? "tortoise" : "speedometer")
                                   }
                               }
                               .accentColor(.primary)
                links
                Button {
                    signOutUser()
                    isLogged = false
                    dismiss()
                } label: {
                    Text("Sign out")
                }
                .tint(.red)
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Account")
            .navigationBarItems(trailing:Button {dismiss() }label: {
                    Text("Close").bold()
            })
        }
    }
    var profile: some View {
        VStack{
            AvatarView()
                .symbolVariant(.circle.fill)
                .font(.system(size: 32))
                .symbolRenderingMode(.palette)
                .foregroundStyle(.blue,.blue.opacity(0.3))
                .padding()
                .background(Circle().fill(.ultraThinMaterial))
                .background(
                    HexagonView()
                        .offset(x:-50, y: -100)
                )
                .background(
                    BlobView()
                        .offset(x:200,y:0)
                        .scaleEffect(0.6)
                )
            Text("Wiktor Jankowski")
                .font(.title.weight(.semibold))
            HStack{
                Image(systemName: "location")
                    .imageScale(.medium)
                Text("Poland")
                    .foregroundColor(.secondary)
            }
            
        }
            .frame(maxWidth:.infinity)
    }
    var menu: some View {
        Section {
            
            /*HStack {
                Label("Settings", systemImage: "gear")
                NavigationLink(destination: HomeView()){
                    Label("Settings", systemImage: "gear")
                }
                .opacity(0)
                     }
            HStack {
                Label("Billing", systemImage: "creditcard")
                NavigationLink {Text("Billing") } label: {
                    Label("Billing", systemImage: "creditcard")
                }
                .opacity(0)
            }*/
            Button(action: {
               EmailHelper.shared.sendEmail(subject: "[HoloRace] Help Request", body: "", to: "holorace@putmotorsport.pl")
             }) {
                 Label("Help",systemImage: "questionmark")
             }
        }
        .accentColor(.primary)
        .listRowSeparatorTint(.blue)
        .listRowSeparator(.hidden)
    }
    var links: some View {
            Section {
                if !isDeleted {
                Link(destination: URL(string: "https://putmotorsport.pl")!){
                    HStack {
                        Label("Website", systemImage: "house")
                        Spacer()
                        Image(systemName: "link")
                            .foregroundColor(.secondary)
                    }
                }
                .swipeActions(edge: .leading, allowsFullSwipe: true) {
                    Button(action: { isDeleted = true }) {
                        Label("Delete", systemImage: "trash")
                    }
                    .tint(.red)
                    Button{} label: {
                        Label("Pin", systemImage: "pin")
                    }
                    .tint(.yellow)
                }
            }
        }
            .accentColor(.primary)
    }
    func signOutUser() {
        signOutProcessing = true
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
            signOutProcessing = false
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
