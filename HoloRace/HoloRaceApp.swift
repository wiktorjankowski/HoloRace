//
//  HoloRaceApp.swift
//  HoloRace
//
//  Created by Wiktor Jankowski on 27/04/2022.
//

import SwiftUI
import Firebase

@main
struct HoloRaceApp: App {
    @StateObject var model = Model()
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(model)
        }
    }
}
