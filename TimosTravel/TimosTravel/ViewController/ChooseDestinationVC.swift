//
//  ChooseDestinationVC.swift
//  TimosTravel
//
//  Created by timofey makhlay on 5/15/19.
//  Copyright © 2019 Timofey Makhlay. All rights reserved.
//

import UIKit
import SnapKit

class ChooseLocationVC: UIViewController {
    
    // Creating table view
    var tableView = UITableView()
    
    // Current Location
    let viewNavbarTitle: UITextView = {
        var title = UITextView()
        title.text = "LocationName"
        title.font = UIFont(name: "AvenirNext-Medium", size: UIScreen.main.bounds.height * 0.036)
        title.textColor = #colorLiteral(red: 0.1075617597, green: 0.09771008044, blue: 0.1697227657, alpha: 1)
        title.backgroundColor = nil
        title.textAlignment = .center
        title.isEditable = false
        title.isScrollEnabled = false
        return title
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        loadEverything()
        addTableView()
    }
    
    func loadEverything() {
        view.addSubview(viewNavbarTitle)
        
        viewNavbarTitle.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset((navigationController?.navigationBar.bounds.height)! + 100)
            make.centerX.equalToSuperview()
        }
    }
    
    func addTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.bottom.left.right.equalToSuperview()
            make.top.equalTo(viewNavbarTitle.snp.bottom).offset(10)
        }
        
        // Register Table View Cells
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "wayCell")
//        tableView.delegate = self
        tableView.dataSource = self
        
        // Table View
        //tableView.backgroundColor = view.backgroundColor
    }
}
extension ChooseLocationVC: UITableViewDataSource {
    // Table View Rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // Table View Cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "wayCell", for: indexPath as IndexPath)
        
        // TODO: Check if there are items in the list. If not say "Tap "+" to add waypoints"
        cell.textLabel?.text = "Working"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: Open that location on the map
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // TODO: Delete location from list and data
        }
    }
}