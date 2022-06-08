//
//  TestView.swift
//  HoloRace
//
//  Created by Wiktor Jankowski on 15/05/2022.
//

import SwiftUI
import Firebase

struct TestView: View {
    @ObservedObject private var viewModel = RaceList()
    @State var show = false
    @Namespace var namespace
    @State var selectedIndex = 0
    var body: some View {
        //let user = Auth.auth().currentUser
            ScrollView{
                VStack{
                    content
                }
                
            }
            .onAppear(){

                    self.viewModel.fetchDataLog()
                
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
        /*else
        {
            
            
        }*/
        
        
        
        
    }
    var content: some View {
        //NavigationView {
        //Array(tracks.enumerated()),id: \.offset
        ForEach(viewModel.racetime){race in
                Button {
                    show = true
                   // selectedIndex = index
                } label: {
                        HStack(alignment: .top, spacing: 12){
                            Image(race.Image ?? "")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 44, height: 44)
                                .background(Color("Background"))
                                .mask(Circle())
                            VStack(alignment: .leading, spacing: 4) {
                                Text(race.track ?? "").bold()
                                    .foregroundColor(.primary)
                                Text(race.Date ?? "")
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

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
