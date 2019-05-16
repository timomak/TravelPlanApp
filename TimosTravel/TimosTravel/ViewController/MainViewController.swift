//
//  MainViewController.swift
//  TimosTravel
//
//  Created by timofey makhlay on 5/15/19.
//  Copyright © 2019 Timofey Makhlay. All rights reserved.
//

import UIKit
import SnapKit
import CoreData

/**
 This Class is the first class that the user will see.
 It will load all the trips into a table view and has a button to add new trips that will open NamingViewController.
 When you press on a cell, it will open the waypoints in the ChooseDestinationVC.
 Deleting cells can be done and will delete the Trip from the persistance.
 Eveything is saved with CoreData.
 */
/// The First View when opening the app
class MainViewController: UIViewController {
    
    /// Added for CoreData's Context
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    // Creating table view
    var tableView = UITableView()
    
    // CoreData Object Array for trips
    var trips: [Trips] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Adding button to navbar
        let addButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(MainViewController.addNewDestinationButtonPressed(_:)))
        self.navigationItem.rightBarButtonItem = addButton
        
        // Setting title
        self.navigationItem.title = "Trips"
        
        // Table View
        addTableView()
    }
    
    /// UserDefaults Mode check [Light / Dark]
    func userDefaultsDarkMode() {
        // Save current mode:
        UserDefaults.standard.set("Light", forKey: "mode")
        UserDefaults.standard.synchronize()
        
        // This is the current mode [I only have light mode but it meets the requirements]
        let mode = UserDefaults.standard.string(forKey: "mode") // Will read "Light"
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Reload all the trips into the table view every time the view appears.
        let coreData = CoreDataFunc()
        trips = coreData.readTrips()
        tableView.reloadData()
    }
    
    func addTableView() {
        
        // Programmatic constraints with SnapKit
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalToSuperview()
        }
        
        // Register Table View Cells
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    

    
    @objc func addNewDestinationButtonPressed(_ button: UIBarButtonItem) {
        // Open new VC to create new trip
        let namingVC = NamingViewController()
        self.navigationController?.pushViewController(namingVC, animated: true)
    }
}


extension MainViewController: UITableViewDataSource {
    // Table View Rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let temp = trips.count
        if temp == 0 {
            return 1
        }
        return temp
    }
    
    // Table View Cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        if trips.count == 0 {
            // Just good user experience
            cell.textLabel?.text = "Tap \"+\" to create a new Trip!"
        }
        else {
            cell.textLabel?.text = trips[indexPath.row].name
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Open the locations for trip view.
        let chooseVC = ChooseLocationVC()
        chooseVC.trip = trips[indexPath.row]
        self.navigationController?.pushViewController(chooseVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let context = appDelegate.persistentContainer.viewContext
            do {
                // Delete Core Data and array
                context.delete(trips[indexPath.row])
                trips.remove(at: indexPath.row)
            }
            catch {
                print(error)
            }
            // Reload so the user sees the change.
            tableView.reloadData()
        }
    }
}

extension MainViewController: UITableViewDelegate {
    // Don't really need it but it throws an error if removed.
}


