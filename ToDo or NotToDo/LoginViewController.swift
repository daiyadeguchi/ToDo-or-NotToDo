//
//  ViewController.swift
//  ToDo or NotToDo
//
//  Created by Daiya Deguchi on 2022/07/16.
//

import UIKit

class LoginViewController: UIViewController {
    
    lazy var segmentedControl: UISegmentedControl = {
        var segControl = UISegmentedControl(items: ["Sign Up", "Sign In"])
        segControl.selectedSegmentIndex = 0
        segControl.backgroundColor = .lightGray
        segControl.addTarget(self, action: #selector(self.segmentedValueChanged(_:)), for: .valueChanged)
        segControl.translatesAutoresizingMaskIntoConstraints = false
        return segControl
    }()
    
    let usernameTextField: UITextField = {
        var text = UITextField()
        text.backgroundColor = .lightGray
        text.layer.cornerRadius = 10
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    let passwordTextField: UITextField = {
        var text = UITextField()
        text.backgroundColor = .lightGray
        text.layer.cornerRadius = 10
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    let submitButton: UIButton = {
        var button = UIButton()
        button.setTitle("Submit", for: .normal)
        button.backgroundColor = .lightGray
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "WELCOME"
        
        let segmentView: UIView = UIView()
        segmentView.translatesAutoresizingMaskIntoConstraints = false
        segmentView.addSubview(segmentedControl)
        
        let userInputView: UIStackView = UIStackView(arrangedSubviews: [usernameTextField, passwordTextField])
        userInputView.translatesAutoresizingMaskIntoConstraints = false
        userInputView.distribution = .equalCentering
        userInputView.axis = .vertical
        userInputView.spacing = 4
        
        let buttonView: UIView = UIView()
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        buttonView.addSubview(submitButton)
        
        let loginStack = UIStackView(arrangedSubviews: [segmentView, userInputView, buttonView])
        loginStack.translatesAutoresizingMaskIntoConstraints = false
        loginStack.axis = .vertical
        
        view.addSubview(loginStack)
        
        NSLayoutConstraint.activate([
            loginStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            loginStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            loginStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            loginStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            segmentView.heightAnchor.constraint(equalTo: loginStack.heightAnchor, multiplier: 0.4),
            userInputView.heightAnchor.constraint(equalTo: loginStack.heightAnchor, multiplier: 0.2),
            buttonView.heightAnchor.constraint(equalTo: loginStack.heightAnchor, multiplier: 0.4),
            
            usernameTextField.heightAnchor.constraint(equalToConstant: 50),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            segmentedControl.centerXAnchor.constraint(equalTo: segmentView.centerXAnchor),
            segmentedControl.centerYAnchor.constraint(equalTo: segmentView.centerYAnchor),
            
            submitButton.centerXAnchor.constraint(equalTo: buttonView.centerXAnchor),
            submitButton.centerYAnchor.constraint(equalTo: buttonView.centerYAnchor),
        ])
    }

    @objc func segmentedValueChanged(_ sender:UISegmentedControl!) {
        print("Selected Segment Index is : \(sender.selectedSegmentIndex)")
    }
}

