//
//  NamingViewController.swift
//  TimosTravel
//
//  Created by timofey makhlay on 5/15/19.
//  Copyright © 2019 Timofey Makhlay. All rights reserved.
//

import UIKit
import SnapKit

class NamingViewController: UIViewController {
    // Textfield for new name
    private let nameTextField: UITextField = {
        var textField = UITextField()
        textField.placeholder = "name"
        textField.font = UIFont(name: "AvenirNext-Bold", size: 28)
        textField.textColor = #colorLiteral(red: 0.1294117647, green: 0.1294117647, blue: 0.1294117647, alpha: 1)
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.keyboardType = UIKeyboardType.emailAddress
        textField.returnKeyType = UIReturnKeyType.default
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        textField.textAlignment = .center
        textField.tag = 0
        return textField
    }()
    
    var previousController: MainViewController = MainViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let saveButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(NamingViewController.saveButtonPressed(_:)))
        self.navigationItem.rightBarButtonItem = saveButton
        self.navigationItem.title = "Trips"
        
        print("In Naming VC")
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.navigationController?.title = "New Trip"
        loadInputItems()
    }
    
    @objc func saveButtonPressed(_ button: UIBarButtonItem) {
        
        print("Named:" , nameTextField.text ?? "🤷‍♂️")
        
        // TODO: Save Name data to Core Data
        let coreData = CoreDataFunc()
        coreData.saveTrip(name: nameTextField.text ?? "🤷‍♂️")
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func loadInputItems() {
        let tinyView = UIView()
        tinyView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        tinyView.layer.cornerRadius = 30
        tinyView.layer.shadowOpacity = 0.7
        tinyView.layer.shadowRadius = 5
        tinyView.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        view.addSubview(tinyView)
        
        print(view.bounds.height)
        
        view.addSubview(tinyView)
        view.addSubview(nameTextField)
        nameTextField.snp.makeConstraints { (make) in
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(view).offset(300)
            make.width.equalToSuperview().offset(-40)
        }
        
        tinyView.snp.makeConstraints { (make) in
            make.centerX.centerY.equalTo(nameTextField)
            make.width.equalTo(nameTextField).offset(10)
            make.height.equalTo(nameTextField).offset(100)
        }
    }
}
