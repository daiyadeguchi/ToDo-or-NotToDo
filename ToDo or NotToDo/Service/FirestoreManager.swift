//
//  FirestoreManager.swift
//  ToDo or NotToDo
//
//  Created by Daiya Deguchi on 2022/08/06.
//

import Foundation
import FirebaseFirestore

class FirestoreManager {
    
    public static let shared = FirestoreManager()
    let db = Firestore.firestore()
    
    func addCategory(owner: String, category: String) {
        db.collection("items").addDocument(data: [
            "owner": owner,
            "category": category,
            "date": Date().timeIntervalSince1970
        ]) { (error) in
            if let e = error {
                print(e.localizedDescription)
            } else {
                print("Category added")
            }
        }
    }
}
