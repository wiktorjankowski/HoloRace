//
//  BookingView.swift
//  HoloRace
//
//  Created by Wiktor Jankowski on 16/05/2022.
//

import SwiftUI

struct BookingView: View {
    @State var text = ""
    @State var show = false
    @Namespace var namespace
    @State var selectedIndex = 0
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ScrollView {
            VStack {
                content
            }
            .padding(20)
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
            .strokeStyle(cornerRadius: 30)
            .padding(20)
            .background(
                Rectangle()
                    .fill(.regularMaterial)
                    .frame(height: 200)
                    .frame(maxHeight: .infinity, alignment: .top)
                    .blur(radius: 20)
                    .offset(y: -200)
            )
            .background(
                Image("Blob 1").offset(x: -100, y: -200)
            )
        }
        .sheet(isPresented:$show) {
            CalendarView()
        }
    }
    var content: some View {
        ForEach(Array(tracks.enumerated()),id: \.offset) { index, item in
            if item.title.contains(text) || text == ""
            {
                if index != 0 { Divider() }
                Button {
                    show = true
                    selectedIndex = index
                } label: {
                    HStack(alignment: .top, spacing: 12) {
                        Image(item.logo)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 44, height: 44)
                            .background(Color("Background"))
                            .mask(Circle())
                        VStack(alignment: .leading, spacing: 4) {
                            Text(item.title).bold()
                                .foregroundColor(.primary)
                            Text(item.location)
                                .font(.footnote)
                                .foregroundColor(.secondary)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .multilineTextAlignment(.leading)
                        }
                    }
                    .padding(.vertical, 4)
                    .listRowSeparator(.hidden)
                }
            }
            
        }
    }
}

struct BookingView_Previews: PreviewProvider {
    static var previews: some View {
        BookingView()
    }
}
