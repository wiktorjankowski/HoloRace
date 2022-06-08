//
//  AvatarView.swift
//  HoloRace
//
//  Created by Wiktor Jankowski on 11/05/2022.
//

import SwiftUI

struct AvatarView: View {
    @AppStorage("isLogged") var isLogged = true
    
    var body: some View {
        Group {
            if isLogged {
                AsyncImage(url: URL(string: "https://media-exp1.licdn.com/dms/image/C4E03AQHvN7pwh8jnOQ/profile-displayphoto-shrink_200_200/0/1609776191572?e=1657756800&v=beta&t=tjtOBvF7rit4gLhopQUNkCboVyX9O1yLpPqUm_L_ZbU"), transaction: Transaction(animation: .easeOut)) { phase in
                    switch phase {
                    case .success(let image):
                        image.resizable()
                            .transition(.scale(scale: 0.5, anchor: .center))
                    case .empty:
                        ProgressView()
                    case .failure(_):
                        Color.gray
                    @unknown default:
                        EmptyView()
                    }
                }
            } else {
                Image("Avatar Default")
                    .resizable()
            }
        }
        .frame(width: 26, height: 26)
        .cornerRadius(10)
        .padding(8)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
        .strokeStyle(cornerRadius: 18)
    }
}

struct AvatarView_Previews: PreviewProvider {
    static var previews: some View {
        AvatarView(isLogged: true)
    }
}

