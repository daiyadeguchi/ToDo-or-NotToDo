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
        
        navigationItem.title = category
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        
        setupGestureRecognizers()
        loadItem()
    }
    
    private func setupGestureRecognizers() {
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeAction(swipe:)))
        leftSwipe.direction = UISwipeGestureRecognizer.Direction.left
        view.addGestureRecognizer(leftSwipe)
    }
    
    @objc func swipeAction(swipe: UISwipeGestureRecognizer) {
        self.dismiss(animated: true)
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
                        if let item = data["item"] as? [[String: Any]] {
                            self.items.append(Item(item: item))
                            print(self.items)
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
