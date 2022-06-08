//
//  Tab.swift
//  HoloRace
//
//  Created by Wiktor Jankowski on 27/04/2022.
//

import SwiftUI

struct TabItem: Identifiable {
    var id = UUID()
    var text: String
    var icon: String
    var tab: Tab
    var color: Color
}

var tabItems = [
    TabItem(text: "Home", icon: "house", tab: .home, color: .teal),
    TabItem(text: "Booking", icon: "calendar", tab: .profile, color: .pink),
    TabItem(text: "Metaverse", icon: "gamecontroller", tab: .notifications, color: .blue),
    TabItem(text:"Races", icon: "bolt", tab: .races, color: .orange)
]

enum Tab: String {
    case home
    case notifications
    case races
    case profile
}

struct TabPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
