//
//  Races.swift
//  HoloRace
//
//  Created by Wiktor Jankowski on 15/05/2022.
//

import Foundation
import SwiftUI

struct Race: Codable, Identifiable{
    var id: String? = UUID().uuidString
    var userid: String?
    var track: String?
    var Q1: String?
    var Q2: String?
    var Q3: String?
    var RacePosition: String?
    var RaceTime: String?
    var Image: String?
    var Date: String?
}

