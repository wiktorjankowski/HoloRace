//
//  HomeView.swift
//  HoloRace
//
//  Created by Wiktor Jankowski on 28/04/2022.
//

import SwiftUI

struct HomeView: View {
    @State var hasScrolled = false
    @Namespace var namespace
    @State var show = false
    @State var selectedID = UUID()
    @State var showTrack = false
    @State var selectedIndex = 0
    @EnvironmentObject var model: Model
    @AppStorage("isLiteMode") var isLiteMode = true
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            ScrollView {
                scrollDetection
                featured
                Text("Tracks".uppercased())
                    .font(.footnote.weight(.semibold))
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal,20)
                LazyVGrid(columns: [GridItem(.adaptive(minimum:300),spacing:20)],spacing:20) {
                    if !show {
                        cards
                    }
                    else {
                        ForEach(tracks) {track in
                            Rectangle()
                                .fill(.white)
                                .frame(height:300)
                                .cornerRadius(30)
                                .shadow(color: Color("Shadow"),radius:20,x:0,y:10)
                                .opacity(0.3)
                                .padding(.horizontal,30)
                        }
                    }
                }
                .padding(.horizontal,20)
            }
            .coordinateSpace(name: "scroll")
            
            .overlay(
                NavigationBar(title: "HoloRace", hasScrolled: $hasScrolled)
        )
            if show {
                detail
            }
            
        }
    }
    var scrollDetection: some View {
        GeometryReader { proxy in
            Color.clear.preference(key: ScrollPreferenceKey.self, value: proxy.frame(in: .named("scroll")).minY)
        }
        .frame(height: 0)
        .onPreferenceChange(ScrollPreferenceKey.self, perform:{
            value in
            withAnimation(.easeInOut) {
                if value<0 {
                    hasScrolled = true
                } else {
                    hasScrolled = false
                }
            }
        })
        .safeAreaInset(edge: .top, content: {
            Color.clear.frame(height:70)
        })
    }
    var featured: some View {
        TabView {
            ForEach(Array(featuredTracks.enumerated()),id: \.offset) { index, track in
                GeometryReader { proxy in
                    let minX = proxy.frame(in: .global).minX
                    FeaturedItem(track: track)
                        .frame(maxWidth:500)
                        .frame(maxWidth:.infinity)
                        .padding(.vertical, 40)
                        .rotation3DEffect(.degrees(minX / -10), axis: (x: 0, y:1, z: 0))
                        .shadow(color:Color("Shadow").opacity(isLiteMode ? 0: 0.3),radius: 10, x: 0, y: 10)
                        .blur(radius: abs(minX/40))
                        .overlay(
                            Image(track.image)
                                .resizable()
                                .aspectRatio(contentMode:.fit)
                                .frame(height:150)
                                .offset(x:60,y:-90)
                                .offset(x: minX / 2)
                        )
                        .onTapGesture {
                            showTrack = true
                            selectedIndex = index
                        }
                }
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(height:430)
        .background(
            Image("Blob 1")
            .offset(x:170,y:-100))
        .sheet(isPresented: $showTrack) {
            TrackView(namespace: namespace, track: featuredTracks[selectedIndex], show: $showTrack)
        }
    }
    var cards: some View {
        ForEach(tracks){ track in
            TrackItem(namespace: namespace, track: track, show: $show)
                .onTapGesture {
                    withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                        show.toggle()
                        model.showDetail.toggle()
                        selectedID = track.id
                    }
                }
        }
    }
    var detail: some View {
        ForEach(tracks) { track in
            if track.id == selectedID {
                TrackView(namespace: namespace, track: track, show: $show)
                    .zIndex(1)
                    .transition(.asymmetric(
                        insertion: .opacity.animation(.easeInOut(duration:0.1)),
                        removal: .opacity.animation(.easeInOut(duration:0.3).delay(0.2))))
            }
            
        }
        
    
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(Model())
    }
}
