//
//  AddPopupView.swift
//  ToDo or NotToDo
//
//  Created by Daiya Deguchi on 2022/07/26.
//

import UIKit

class AddPopupWindowView: UIView {
    
    let popupTitle: UILabel = {
        var label = UILabel()
        label.text = "Add Category"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let popupTextField: UITextField = {
        var textField = UITextField()
        textField.placeholder = "Category"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var addButton: UIButton = {
        var button = UIButton()
        button.setTitle("Add", for: .normal)
        button.addTarget(self, action: #selector(addCategory), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var cancelButton: UIButton = {
        var button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
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
    
    let container: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 24
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init() {
        super.init(frame: CGRect.zero)
        frame = UIScreen.main.bounds
        
        addSubview(container)
        container.addSubview(popupTitle)
        container.addSubview(popupTextField)
        container.addSubview(buttonStack)
        
        NSLayoutConstraint.activate([
            container.centerXAnchor.constraint(equalTo: centerXAnchor),
            container.centerYAnchor.constraint(equalTo: centerYAnchor),
            container.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7),
            container.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4),
            
            popupTitle.topAnchor.constraint(equalTo: container.topAnchor),
            popupTitle.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            popupTitle.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            popupTitle.bottomAnchor.constraint(equalTo: popupTextField.bottomAnchor),

            popupTextField.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            popupTextField.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            popupTextField.heightAnchor.constraint(equalToConstant: 50),
            popupTextField.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.8),

            buttonStack.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            buttonStack.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            buttonStack.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -20)
        ])
    }
    
    @objc func addCategory() {
        if let category = popupTextField.text {
            print(category)
            popupTextField.text = ""
            self.isHidden = true
        }
    }
    
    @objc func dismissView() {
        self.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
