//
//  ViewController.swift
//  ToDo or NotToDo
//
//  Created by Daiya Deguchi on 2022/07/16.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    lazy var segmentedControl: UISegmentedControl = {
        var segControl = UISegmentedControl(items: ["Sign Up", "Sign In"])
        segControl.selectedSegmentIndex = 0
        segControl.backgroundColor = .secondarySystemBackground
        segControl.addTarget(self, action: #selector(self.segmentedValueChanged(_:)), for: .valueChanged)
        segControl.translatesAutoresizingMaskIntoConstraints = false
        return segControl
    }()
    
    lazy var segmentedView: UIView = {
        let segmentView: UIView = UIView()
        segmentView.translatesAutoresizingMaskIntoConstraints = false
        segmentView.addSubview(segmentedControl)
        return segmentView
    }()
    
    let emailTextField: UITextField = {
        var text = UITextField()
        text.placeholder = "Email"
        text.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
        text.leftViewMode = .always
        text.backgroundColor = .secondarySystemBackground
        text.layer.cornerRadius = 10
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    let passwordTextField: UITextField = {
        var text = UITextField()
        text.placeholder = "Password"
        text.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
        text.leftViewMode = .always
        text.isSecureTextEntry = true
        text.backgroundColor = .secondarySystemBackground
        text.layer.cornerRadius = 10
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    lazy var userInputView: UIStackView = {
        let inputView: UIStackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField])
        inputView.translatesAutoresizingMaskIntoConstraints = false
        inputView.distribution = .equalCentering
        inputView.axis = .vertical
        inputView.spacing = 4
        return inputView
    }()
    
    lazy var submitButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "Sign Up"
        config.baseBackgroundColor = .secondarySystemBackground
        config.buttonSize = .large
        config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        var button = UIButton(configuration: config, primaryAction: nil)
        button.addTarget(self, action: #selector(self.buttonPressed(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var buttonView: UIView = {
        let btnView: UIView = UIView()
        btnView.translatesAutoresizingMaskIntoConstraints = false
        btnView.addSubview(submitButton)
        return btnView
    }()
    
    lazy var loginStack: UIStackView = {
        let liStack = UIStackView(arrangedSubviews: [segmentedView, userInputView, buttonView])
        liStack.translatesAutoresizingMaskIntoConstraints = false
        liStack.axis = .vertical
        return liStack
    }()
    
    let userDefault = UserDefaults.standard
    let launchedBefore = UserDefaults.standard.bool(forKey: "usersignedin")

    override func viewDidLoad() {
        // push CategoryVC if user have signed in before (usersignedin == true in userdefault)
        if userDefault.bool(forKey: "usersignedin") {
            self.navigationController?.pushViewController(CategoryViewController(), animated: true)
        }
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        initiateText()
        view.backgroundColor = .systemBackground
        navigationItem.title = "WELCOME"
        submitButton.setTitleColor(UIColor.label, for: .normal)
        view.addSubview(loginStack)
        NSLayoutConstraint.activate([
            loginStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            loginStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            loginStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            loginStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            segmentedView.heightAnchor.constraint(equalTo: loginStack.heightAnchor, multiplier: 0.4),
            userInputView.heightAnchor.constraint(equalTo: loginStack.heightAnchor, multiplier: 0.2),
            buttonView.heightAnchor.constraint(equalTo: loginStack.heightAnchor, multiplier: 0.4),
            
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            segmentedControl.centerXAnchor.constraint(equalTo: segmentedView.centerXAnchor),
            segmentedControl.centerYAnchor.constraint(equalTo: segmentedView.centerYAnchor),
            
            submitButton.centerXAnchor.constraint(equalTo: buttonView.centerXAnchor),
            submitButton.centerYAnchor.constraint(equalTo: buttonView.centerYAnchor),
        ])
    }

    @objc func segmentedValueChanged(_ sender:UISegmentedControl!) {
        if segmentedControl.selectedSegmentIndex == 0 {
            submitButton.setTitle("Sign Up", for: .normal)
            initiateText()
        } else if segmentedControl.selectedSegmentIndex == 1 {
            submitButton.setTitle("Sign In", for: .normal)
            initiateText()
        }
    }
    
    private func initiateText() {
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    
    @objc func buttonPressed(_ sender:UIButton!) {
        if segmentedControl.selectedSegmentIndex == 0 {
            if let email = emailTextField.text, let password = passwordTextField.text {
                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    if let e = error {
                        print(e.localizedDescription)
                    } else {
                        self.pushCategoryView()
                    }
                }
            }
            
        } else if segmentedControl.selectedSegmentIndex == 1 {
            if let email = emailTextField.text, let password = passwordTextField.text {
                Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
                    if let e = error {
                        print(e.localizedDescription)
                    } else {
                        self?.pushCategoryView()
                    }
                    
                }
            }
        } else {
            print("Error: Segmented Control Index doesn't exist")
        }
    }
    
    private func pushCategoryView() {
        self.userDefault.set(true, forKey: "usersignedin")
        self.userDefault.synchronize()
        self.navigationController?.pushViewController(CategoryViewController(), animated: true)
    }
}

