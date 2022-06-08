//
//  TrackItem.swift
//  HoloRace
//
//  Created by Wiktor Jankowski on 28/04/2022.
//

import SwiftUI

struct TrackItem: View {
    var namespace: Namespace.ID
    var track: Track = tracks[0]
    @Binding var show: Bool
    var body: some View {
        VStack {
            Spacer()
            VStack(alignment: .leading, spacing: 12) {
                Text(track.title)
                    .font(.largeTitle.weight(.bold))
                    .matchedGeometryEffect(id: "title\(track.id)", in: namespace)
                .frame(maxWidth: .infinity, alignment: .leading)
                Text(track.subtitle.uppercased())
                    .font(.footnote.weight(.semibold))
                    .matchedGeometryEffect(id: "subtitle\(track.id)", in: namespace)
                Text(track.text)
                    .font(.footnote)
                    .lineLimit(2)
                    .matchedGeometryEffect(id: "text\(track.id)", in: namespace)
            }
            .padding(20)
            .background(
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
                    .blur(radius: 30)
                    .matchedGeometryEffect(id: "blur\(track.id)", in: namespace)
            )
        }
        .foregroundStyle(.white)
        /*.background(
            Image(track.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 180)
                .offset(x:0,y:-60)
                .matchedGeometryEffect(id: "image\(track.id)", in: namespace)
        )*/
        .background(
            Image(track.background)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .matchedGeometryEffect(id: "background\(track.id)", in: namespace)
        )
        .mask(
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .matchedGeometryEffect(id: "mask\(track.id)", in: namespace)
        )
        .frame(height: 300)
    }
}

struct TrackItem_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        TrackItem(namespace: namespace,show:.constant(true))
    }
}
