//
//  CategoryViewController.swift
//  ToDo or NotToDo
//
//  Created by Daiya Deguchi on 2022/07/21.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class CategoryViewController: UIViewController {
    
    var tableView = UITableView()
    var popup = AddPopupWindowView()
    let firestore = Firestore.firestore()
    var items: [Category] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        view.addSubview(popup)
        popup.isHidden = true
        
        navigationItem.setHidesBackButton(true, animated: true)
        navigationItem.title = "Category"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCategory))
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        
        loadCategory()
    }
    
    private func loadCategory() {
        firestore.collection("items").whereField("owner", isEqualTo: Auth.auth().currentUser?.email! as Any).order(by: "date").addSnapshotListener { querySnapshot, error in
            self.items = []
            if let e = error {
                print(e.localizedDescription)
            } else {
                if let snapshotDocuments = querySnapshot?.documents {
                    for doc in snapshotDocuments {
                        let data = doc.data()
                        if let category = data["category"] as? String, let owner = data["owner"] as? String {
                            self.items.append(Category(category: category, owner: owner))
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                self.tableView.scrollToRow(at: IndexPath(row: self.items.count - 1, section: 0), at: .top, animated: true)
                            }
                        }
                    }
                }
            }
        }
    }
    
    @objc func addCategory() {
        popup.isHidden = false
    }
}
