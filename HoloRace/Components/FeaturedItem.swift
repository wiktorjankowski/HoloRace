//
//  FeaturedItem.swift
//  HoloRace
//
//  Created by Wiktor Jankowski on 28/04/2022.
//

import SwiftUI

struct FeaturedItem: View {
    var track: Track = tracks[0]
    var body: some View {
        VStack(alignment: .leading, spacing: 8.0){
            Spacer()
            Image(track.logo)
                .resizable(resizingMode: .stretch)
                .aspectRatio(contentMode: .fit)
                .frame(width: 26.0, height: 26.0)
                .cornerRadius(/*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)
                .padding(9)
                .background(Color(UIColor.systemBackground).opacity(0.1), in: RoundedRectangle(cornerRadius:20, style: .continuous))
                .strokeStyle(cornerRadius:20)
            Text(track.title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(.linearGradient(colors:[.primary,.blue],startPoint: .topLeading,endPoint:.bottomTrailing))
            Text(track.subtitle.uppercased())
                .font(.footnote)
                .fontWeight(.semibold)
                .foregroundColor(.secondary)
            Text(track.text)
                .multilineTextAlignment(.leading)
                .lineLimit(2)
                .frame(maxWidth:.infinity,alignment: .leading)
                .foregroundColor(.secondary)
        }
        .padding(.all, 20.0)
        .padding(.vertical, 20)
        .frame(height: 350.0)
        .background(.ultraThinMaterial)
        .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .strokeStyle()
        .padding(.horizontal, 20)
    }
}

struct FeaturedItem_Previews: PreviewProvider {
    static var previews: some View {
        FeaturedItem()
    }
}
