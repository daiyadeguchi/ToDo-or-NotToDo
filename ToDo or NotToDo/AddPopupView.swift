//
//  AddPopupView.swift
//  ToDo or NotToDo
//
//  Created by Daiya Deguchi on 2022/07/26.
//

import UIKit

class AddPopupView: UIViewController {
    
    private let popupWindowView = AddPopupWindowView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        modalTransitionStyle = .crossDissolve
        modalPresentationStyle = .overFullScreen
        
        if popupWindowView.popupTextField.text != nil {
            popupWindowView.addButton.addTarget(self, action: #selector(addCategory), for: .touchUpInside)
        }
        popupWindowView.cancelButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        view = popupWindowView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func addCategory() {
        print(popupWindowView.popupTextField.text!)
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func dismissView() {
        self.dismiss(animated: true, completion: nil)
    }
}
