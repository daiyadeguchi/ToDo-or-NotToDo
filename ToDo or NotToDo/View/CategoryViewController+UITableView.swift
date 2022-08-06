//
//  CategoryViewController+UITableView.swift
//  ToDo or NotToDo
//
//  Created by Daiya Deguchi on 2022/08/06.
//

import UIKit
import FirebaseFirestore

extension CategoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        var config = cell.defaultContentConfiguration()
        config.text = item.category
        cell.contentConfiguration = config
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(ItemViewController(), animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            firestore.collection("items").whereField("category", isEqualTo: items[indexPath.row].category).getDocuments { queryDocument, error in
                if let e = error {
                    print(e.localizedDescription)
                } else {
                    if let snapshotDocuments = queryDocument?.documents {
                        for doc in snapshotDocuments {
                            doc.reference.delete()
                        }
                    }
                }
            }
            items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
