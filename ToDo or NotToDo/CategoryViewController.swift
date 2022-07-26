//
//  CategoryViewController.swift
//  ToDo or NotToDo
//
//  Created by Daiya Deguchi on 2022/07/21.
//

import UIKit

class CategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView = UITableView()
    var popup = AddPopupWindowView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        
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
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        return cell
    }
    
    @objc func addCategory() {
        popup.isHidden = false
    }
}
