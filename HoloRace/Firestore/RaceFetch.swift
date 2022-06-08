//
//  RaceFetcj.swift
//  HoloRace
//
//  Created by Wiktor Jankowski on 15/05/2022.
//

import Foundation
import Firebase
import FirebaseFirestore

class RaceList: ObservableObject {
    @Published var racetime = [Race]()
    private var db = Firestore.firestore()
    
    func fetchDataLog() {
        /*let userID = ""
        if Auth.auth().currentUser!.uid == nil{
            print("Nil")
        }
        else
        {
            
        }*/
        let userID = Auth.auth().currentUser!.uid
        //
        db.collection("races").whereField("userid", isEqualTo: userID)
            .getDocuments() { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            self.racetime = documents.map { (queryDocumentSnapshot) -> Race in
                let data = queryDocumentSnapshot.data()
                print(userID)
                let id = data["id"] as? UUID
                let track = data["track"] as? String ?? ""
                let Image = data["image"] as? String ?? ""
                let Q1 = data["Q1"] as? String ?? ""
                let Q2 = data["Q2"] as? String ?? ""
                let Q3 = data["Q3"] as? String ?? ""
                let RacePosition = data["RacePosition"] as? String ?? ""
                let RaceTime = data["RaceTime"] as? String ?? ""
                let Date = data["Date"] as? String ?? ""
                print(Q1)
                print(track)
                print(Date)
                return Race(track: track, Image: Image, Date: Date/*, Q2: Q2, Q3: Q3, RacePosition: RacePosition, RaceTime: RaceTime*/)
            }
        }
}
}
