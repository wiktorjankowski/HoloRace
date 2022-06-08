//
//  Achievements.swift
//  HoloRace
//
//  Created by Wiktor Jankowski on 11/05/2022.
//

import SwiftUI

struct Achievement: Identifiable {
    let id = UUID()
    var title: String
    var text: String
    var image: String
    var background: String
    var logo: String
    var progress: CGFloat
}

var achievements = [
    Achievement(title: "The Beginning",text:"First race completed", image:"Image",background: "Background 12", logo: "Bronze",progress:1),
    Achievement(title: "Tracked Addiction",text:"Completed 50 hours of track time", image:"Image",background: "Background 13", logo: "Silver",progress:0.5),
    Achievement(title: "Qualifying Master ",text:"Achieved 50 pole positions", image:"Image",background: "Background 14", logo: "Gold",progress:0.75),

]
