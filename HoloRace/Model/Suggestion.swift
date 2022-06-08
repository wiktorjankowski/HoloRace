//
//  Suggestion.swift
//  HoloRace
//
//  Created by Wiktor Jankowski on 11/05/2022.
//

import SwiftUI

struct Suggestion: Identifiable {
    let id = UUID()
    var text: String
}

var suggestions = [
    Suggestion(text: "Hungaroring"),
    Suggestion(text: "Jeddah"),
    Suggestion(text: "Imola")
]
