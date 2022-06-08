//
//  TrackView.swift
//  HoloRace
//
//  Created by Wiktor Jankowski on 28/04/2022.
//

import SwiftUI
import CoreLocation
import Firebase

struct TrackView: View {
    var namespace: Namespace.ID
    var track: Track = tracks[0]
    @Binding var show: Bool
    @State private var isActive: Bool = false
    @State var appear = [false,false,false]
    @State var viewState: CGSize = .zero
    @State var showSection = false
    @State var isDraggable = true
    @State var selectedIndex = 0
    @EnvironmentObject var model: Model
    var body: some View {
        ZStack {
            ScrollView {
                cover
                if Auth.auth().currentUser?.uid != nil
                {
                    content
                        .offset(y:160)
                        .padding(.bottom, 240)
                        .opacity(appear[2] ? 1 : 0)
                }
                else
                {
                    
                }
                }
            .coordinateSpace(name: "scroll")
            .onAppear{
                model.showDetail = true
            }
            .onDisappear{
                model.showDetail = false
            }
            .background(Color("Background"))
            .mask(RoundedRectangle(cornerRadius: viewState.width/3,style:.continuous))
            .shadow(color:.black.opacity(0.3),radius:30,x:0,y:10)
            .scaleEffect(viewState.width / -500 + 1)
            .background(.black.opacity(viewState.width/500))
            .background(.ultraThinMaterial)
            .gesture(isDraggable ? drag : nil)
            .ignoresSafeArea()
            Button {
                withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                    show.toggle()
                    model.showDetail.toggle()
                }
            } label: {
                Image(systemName: "xmark")
                    .font(.body.weight(.bold))
                    .foregroundColor(.secondary)
                    .padding(8)
                    .background(.ultraThinMaterial, in: Circle())
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            .padding(20)
        }
        .onChange(of: show) { newValue in
            fadeOut()
        }
        .onAppear{
            fadeIn()
        }
    }
    var overlayContent: some View {
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
                    .matchedGeometryEffect(id: "text\(track.id)", in: namespace)
                Divider()
                    .opacity(appear[0] ? 1:0)
                    HStack {
                        Image(track.logo)
                            .resizable()
                            .frame(width: 26, height: 26)
                            .cornerRadius(10)
                            .padding(8)
                            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
                            .strokeStyle(cornerRadius: 18)
                       // Spacer()
                        Text(track.location)
                            .font(.footnote)
                            .onTapGesture {
                                UIApplication.shared.openURL(NSURL(string: track.url)! as URL)
                            }
                        Spacer()
                }
                .opacity(appear[1] ? 1:0)
            }
                .padding(20)
                .background(
                    Rectangle()
                        .fill(.ultraThinMaterial)
                        .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
                        .matchedGeometryEffect(id: "blur\(track.id)", in: namespace)
                )
                .offset(y: 250)
                .padding(20)
    }
    var drag: some Gesture {
        DragGesture(minimumDistance:30, coordinateSpace: .local)
            .onChanged { value in
                guard value.translation.width > 0 else {return}
                
                if value.startLocation.x < 100 {
                    withAnimation(.closeCard){
                        viewState = value.translation
                    }
                    
                }
                if viewState.width > 120 {
                    close()
                }
                
            }
            .onEnded { value in
                if viewState.width > 80 {
                    close()
            }
                else {
                    withAnimation(.closeCard){
                        viewState = .zero
                    }
                }
            }
    }
    func fadeIn() {
        withAnimation(.easeOut.delay(0.3)){
            appear[0]=true
        }
        withAnimation(.easeOut.delay(0.4)){
            appear[1]=true
        }
        withAnimation(.easeOut.delay(0.5)){
            appear[2]=true
        }
    }
    func fadeOut() {
        appear[0]=false
        appear[1]=false
        appear[2]=false
    }
    func close () {
        if viewState.width > 80 {
            withAnimation(.closeCard.delay(0.3)) {
                show.toggle()
                model.showDetail.toggle()
            }
        }
        withAnimation(.easeOut){
            viewState = .zero
        }
        isDraggable = false
    }
    var cover: some View {
        GeometryReader { proxy in
            let scrollY = proxy.frame(in:.named("scroll")).minY
            VStack {
                Spacer()
            }
            .frame(maxWidth:.infinity)
            .frame(height:scrollY > 0 ? 500+scrollY : 500)
            .foregroundStyle(.black)
        
        
        .frame(maxWidth: .infinity)
        .frame(height: 500)
        .foregroundStyle(.black)
        /*.background(
            Image(track.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height:250)
               // .offset(x:60,y:-90)
                .matchedGeometryEffect(id: "image\(track.id)", in: namespace)
         .offset(y:scrollY*-0.8)
        )*/
        .background(
            Image(track.background)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .matchedGeometryEffect(id: "background\(track.id)", in: namespace)
                .offset(y:scrollY > 0 ? -scrollY : 0)
                .scaleEffect(scrollY > 0 ?scrollY/1000 + 1 : 1)
                .blur(radius:scrollY/10)
        )
        .mask(
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .matchedGeometryEffect(id: "mask\(track.id)", in: namespace)
                .offset(y:scrollY > 0 ? -scrollY : 0)
        )
        .overlay(
        overlayContent
            .offset(y:scrollY > 0 ? -scrollY * -0.6 : 0)
        )
        }
        .frame(height:500)
    }
    var content: some View {
        VStack(alignment: .leading) {
                    ForEach(Array(achievements.enumerated()), id: \.offset) { index, section in
                        if index != 0 { Divider() }
                        SectionRow(section: section)
                            .onTapGesture {
                                selectedIndex = index
                                showSection = true
                            }
                    }
                }
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
                .strokeStyle(cornerRadius: 30)
                .padding(20)
                .sheet(isPresented: $showSection) {
                    SectionView(section: achievements[selectedIndex])
                }
}
}

struct TrackView_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        TrackView(namespace: namespace, show:.constant(true))
            .environmentObject(Model())
    }
}
