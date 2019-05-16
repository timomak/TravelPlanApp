//
//  MainViewController.swift
//  TimosTravel
//
//  Created by timofey makhlay on 5/15/19.
//  Copyright © 2019 Timofey Makhlay. All rights reserved.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    // Creating table view
    var tableView = UITableView()
    
    // Model Array for trips
    var trips: [Trips] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        let searchButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(MainViewController.addNewDestinationButtonPressed(_:)))
        self.navigationItem.rightBarButtonItem = searchButton
        self.navigationItem.title = "Trips"
        
        let trip1 = Trips()
        trip1.name = "Mexico"
        addTableView()
        trips.append(trip1)
        tableView.reloadData()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // TODO: Save Core Data
    }
    
    func addTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalToSuperview()
        }
        
        // Register Table View Cells
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        // Table View
        //tableView.backgroundColor = view.backgroundColor
    }
    

    
    @objc func addNewDestinationButtonPressed(_ button: UIBarButtonItem) {
        let namingVC = NamingViewController()
//        namingVC.previousController = self
        self.navigationController?.pushViewController(namingVC, animated: true)
//        if searchController == nil {
//            searchController = UISearchController(searchResultsController: nil)
//        }
//        searchController.hidesNavigationBarDuringPresentation = false
//        self.searchController.searchBar.delegate = self
//        present(searchController, animated: true, completion: nil)
    }
}


extension MainViewController: UITableViewDataSource {
    // Table View Rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trips.count
    }
    
    // Table View Cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        cell.textLabel?.text = trips[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: Next VC to celect destination
        let chooseVC = ChooseLocationVC()
        self.navigationController?.pushViewController(chooseVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
        }
    }
}

extension MainViewController: UITableViewDelegate {
    //     Table View Cell Styling
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 70
//    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print("Deselected")
    }
}


