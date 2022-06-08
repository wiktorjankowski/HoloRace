//
//  ContentView.swift
//  HoloRace
//
//  Created by Wiktor Jankowski on 27/04/2022.
//

import SwiftUI
import Firebase

struct ContentView: View {
    @AppStorage("selectedTab") var selectedTab: Tab = .home
    @AppStorage("showModal") var showModal = false
    @EnvironmentObject var model: Model
    //RaceList.fetchDataLog()
    var body: some View {
        ZStack(alignment: .bottom) {
            
                switch selectedTab {
                case .home:
                    HomeView()
                case .profile:
                    if Auth.auth().currentUser?.uid != nil
                    {
                        BookingView()
                    }
                    else
                    {
                        BookingNotLogged()
                    }
                case .notifications:
                    MetaverseView()
                case .races:
                    if Auth.auth().currentUser?.uid != nil
                    {
                        TestView()
                    }
                    else
                    {
                        RaceNotLogged()
                    }
                }
            TabBar()
                .offset(y:model.showDetail ? 200 : 0)
            if showModal {
                ModalView()
                    .zIndex(1)
            }
        }
        .safeAreaInset(edge: .bottom, content: {
            Color.clear.frame(height:44)
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
