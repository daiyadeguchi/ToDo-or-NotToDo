//
//  ItemViewController.swift
//  ToDo or NotToDo
//
//  Created by Daiya Deguchi on 2022/08/05.
//

import UIKit
import FirebaseFirestore

class ItemViewController: UIViewController {
    
    var category: String = ""
    var tableView = UITableView()
    lazy var popup: AddPopupWindowView = {
        var window = AddPopupWindowView()
        window.isCategoryView = false
        window.category = category
        window.popupTitle.text = "Add Item"
        window.popupTextField.placeholder = "Item"
        return window
    }()
    var items: [Item] = []
    let firestore = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        view.addSubview(popup)
        popup.isHidden = true
        
        navigationItem.title = "Item"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        
        loadItem()
    }
    
    private func loadItem() {
        firestore.collection("items").whereField("category", isEqualTo: category).addSnapshotListener { querySnapshot, error in
            self.items = []
            if let e = error {
                print(e.localizedDescription)
            } else {
                if let snapshotDocuments = querySnapshot?.documents {
                    for doc in snapshotDocuments {
                        let data = doc.data()
                        if let item = data["item"] as? [String] {
                            self.items.append(Item(item: item))
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
    
    @objc func addItem() {
        popup.isHidden = false
    }
}

extension ItemViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.isEmpty ? 0 : items[0].item.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        var config = cell.defaultContentConfiguration()
        config.text = items[0].item[indexPath.row]
        cell.contentConfiguration = config
        return cell
    }
}
