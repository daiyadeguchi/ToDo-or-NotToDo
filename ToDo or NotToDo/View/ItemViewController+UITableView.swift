//
//  ItemViewController+UITableView.swift
//  ToDo or NotToDo
//
//  Created by Daiya Deguchi on 2022/08/25.
//

import UIKit
import FirebaseFirestore

extension ItemViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.isEmpty ? 0 : items[0].item.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        var config = cell.defaultContentConfiguration()
        if !items[0].item[indexPath.row].isEmpty {
            for (key, value) in items[0].item[indexPath.row] {
                if key == "isDone" {
                    if let isDone = value as? Bool {
                        config.image = isDone ? UIImage(systemName: "checkmark.circle.fill")?.withTintColor(.label, renderingMode: .alwaysOriginal) : UIImage(systemName: "circle")?.withTintColor(.label, renderingMode: .alwaysOriginal)
                    }
                }
                if key == "item" {
                    config.text = value as? String
                }
            }
            cell.contentConfiguration = config
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let isDoneCurrently = items[0].item[indexPath.row]["isDone"] as! Bool
        if isDoneCurrently == true {
            items[0].item[indexPath.row].updateValue(false, forKey: "isDone")
        } else {
            items[0].item[indexPath.row].updateValue(true, forKey: "isDone")
        }
        
        firestore.collection("items").whereField("category", isEqualTo: category).getDocuments { queryDocument, error in
            if let e = error {
                print(e.localizedDescription)
            } else {
                if let snapshotDocuments = queryDocument?.documents {
                    for doc in snapshotDocuments {
                        doc.reference.updateData([
                            "item": self.items[0].item
                        ])
                    }
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            firestore.collection("items").whereField("category", isEqualTo: category).getDocuments { queryDocument, error in
                if let e = error {
                    print(e.localizedDescription)
                } else {
                    if let snapshotDocuments = queryDocument?.documents {
                        for doc in snapshotDocuments {
                            if !self.items[0].item.isEmpty {
                                doc.reference.updateData([
                                    "item": self.items[0].item
                                ])
                            } else {
                                doc.reference.updateData([
                                    "item": FieldValue.delete()
                                ])
                            }
                        }
                    }
                }
            }
            items[0].item.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
