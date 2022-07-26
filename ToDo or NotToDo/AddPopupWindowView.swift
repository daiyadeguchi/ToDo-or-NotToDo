//
//  AddPopupView.swift
//  ToDo or NotToDo
//
//  Created by Daiya Deguchi on 2022/07/26.
//

import UIKit

class AddPopupWindowView: UIView {
    
    let popupView: UIView = {
        var view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let popupTitle: UILabel = {
        var label = UILabel()
        label.text = "Add Category"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let popupTextField: UITextField = {
        var textField = UITextField()
        textField.backgroundColor = .white
        textField.placeholder = "Category"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let addButton: UIButton = {
        var button = UIButton()
        button.setTitle("Add", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let cancelButton: UIButton = {
        var button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var buttonStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [addButton, cancelButton])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    init() {
        super.init(frame: CGRect.zero)
        backgroundColor = .lightGray
        
        popupView.addSubview(popupTitle)
        popupView.addSubview(popupTextField)
        popupView.addSubview(buttonStack)
        
        addSubview(popupView)
        
        NSLayoutConstraint.activate([
            popupView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            popupView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            popupView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            popupView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            popupTitle.topAnchor.constraint(equalTo: popupView.topAnchor),
            popupTitle.leadingAnchor.constraint(equalTo: popupView.leadingAnchor),
            popupTitle.trailingAnchor.constraint(equalTo: popupView.trailingAnchor),
            popupTitle.bottomAnchor.constraint(equalTo: popupTextField.bottomAnchor),
            
            popupTextField.centerXAnchor.constraint(equalTo: popupView.centerXAnchor),
            popupTextField.centerYAnchor.constraint(equalTo: popupView.centerYAnchor),
            popupTextField.heightAnchor.constraint(equalToConstant: 50),
            popupTextField.widthAnchor.constraint(equalTo: popupView.widthAnchor, multiplier: 0.8),
            
            
            buttonStack.topAnchor.constraint(equalTo: popupTextField.bottomAnchor),
            buttonStack.leadingAnchor.constraint(equalTo: popupView.leadingAnchor),
            buttonStack.trailingAnchor.constraint(equalTo: popupView.trailingAnchor),
            buttonStack.bottomAnchor.constraint(equalTo: popupView.bottomAnchor)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
