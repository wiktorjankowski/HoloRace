//
//  Model.swift
//  HoloRace
//
//  Created by Wiktor Jankowski on 09/05/2022.
//

import SwiftUI
import Combine

class Model: ObservableObject {
    @Published var showDetail: Bool = false
    @Published var selectedModal: Modal = .signIn
}

enum Modal: String {
    case signUp
    case signIn
}
