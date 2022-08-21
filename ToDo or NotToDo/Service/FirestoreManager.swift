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
    
    func addItem(category: String, item: String) {
        db.collection("items").whereField("category", isEqualTo: category).getDocuments { querySnapshot, error in
            if let snapshotDocuments = querySnapshot?.documents {
                for doc in snapshotDocuments {
                    if var items = doc.get("item") as? [[String : Any]] {
                        let itemDictionary: [String : Any] = ["item": item, "isDone": false]
                        items.append(itemDictionary)
                        doc.reference.updateData([
                            "item": items
                        ])
                    } else {
                        doc.reference.updateData([
                            "item": [["item": item, "isDone": false]]
                        ])
                    }
                }
            }
        }
    }
}
