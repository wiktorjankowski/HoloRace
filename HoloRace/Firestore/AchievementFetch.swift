//
//  AchievementFetch.swift
//  HoloRace
//
//  Created by Wiktor Jankowski on 16/05/2022.
//

import Foundation
import Firebase
import FirebaseFirestore

class AchievementList: ObservableObject {
    @Published var achievement = [Achiev]()
    private var db = Firestore.firestore()
    
    func fetchData() {
        let userID = Auth.auth().currentUser!.uid
        db.collection("races").whereField("userid", isEqualTo: userID)
            .getDocuments() { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            self.achievement = documents.map { (queryDocumentSnapshot) -> Achiev in
                let data = queryDocumentSnapshot.data()
                print(userID)
                let id = data["id"] as? UUID
                let track = data["track"] as? String ?? ""
                let image = data["image"] as? String ?? ""
                let background = data["background"] as? String ?? ""
                let logo = data["logo"] as? String ?? ""
                let progress = data["progress"] as! CGFloat
                let text = data["text"] as? String ?? ""
                let title = data["title"] as? String ?? ""
                let userid = data["userid"] as? String ?? ""
                return Achiev(title:title, track: track, text:text, image: image, background: background, logo: logo, progress: progress )
            }
        }
}
}
