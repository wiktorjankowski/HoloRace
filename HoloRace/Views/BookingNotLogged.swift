//
//  BookingNotLogged.swift
//  HoloRace
//
//  Created by Wiktor Jankowski on 16/05/2022.
//

import SwiftUI

struct BookingNotLogged: View {
    var body: some View {
        ZStack(alignment: .top)
        {
            Text("In order to book races, you have to be logged in.")
                .padding(20)
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
                .strokeStyle(cornerRadius: 30)
        }
        .frame(maxWidth: .infinity, alignment: .center)
                .padding(20)
                .background(
                    Rectangle()
                        .fill(.regularMaterial)
                        .frame(height: 200)
                        .frame(maxHeight: .infinity, alignment: .top)
                        .blur(radius: 20)
                        //.offset(y: -200)
                )
                .background(
                    Image("Blob 1").offset(x: -100, y: -200)
                )
    }
}

struct BookingNotLogged_Previews: PreviewProvider {
    static var previews: some View {
        BookingNotLogged()
    }
}
