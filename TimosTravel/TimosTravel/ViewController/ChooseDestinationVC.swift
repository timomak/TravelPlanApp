//
//  ChooseDestinationVC.swift
//  TimosTravel
//
//  Created by timofey makhlay on 5/15/19.
//  Copyright © 2019 Timofey Makhlay. All rights reserved.
//

import UIKit
import SnapKit

/// Loads all the waypoints for the current selected Trip.
class ChooseLocationVC: UIViewController {
    /// The currently selected Trip.
    var trip: Trips?

    /// Table View
    var tableView = UITableView()
    
    /// For CoreData Context
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
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
        
        // Setting the name to be the current trip's name.
        viewNavbarTitle.text = trip?.name

        // Add new destination [Location]
        let searchButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(ChooseLocationVC.addNewDestinationButtonPressed(_:)))
        self.navigationItem.rightBarButtonItem = searchButton
        
        // Temporary name
        self.navigationItem.title = trip?.name
        
        // Layout
        loadEverything()
        
        // Table View
        addTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Load all locations for Trip into table view
        tableView.reloadData()
    }
    
    @objc func addNewDestinationButtonPressed(_ button: UIBarButtonItem) {
        // Open Map VC to create new waypoints
        let mapVC = MapViewController()
        mapVC.trip = trip!
        self.navigationController?.pushViewController(mapVC, animated: true)

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
        tableView.delegate = self
        tableView.dataSource = self
    }
}
extension ChooseLocationVC: UITableViewDataSource {
    // Table View Rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return 1 if no locations.
        let temp = trip?.locations?.count ?? 1
        if temp == 0 {
            return 1
        }
        else {
            return temp
        }
        return temp
    }
    
    // Table View Cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("THis is being called")
        var cell = tableView.dequeueReusableCell(withIdentifier: "wayCell", for: indexPath as IndexPath)
        
        // Check if there are items in the list. If not say "Tap "+" to add waypoints"
        if trip?.locations?.count == 0 {
            cell.textLabel?.text = "Tap to add waypoints"
        }
        else {
            let location = trip?.locations?[indexPath.row] as! Locations
            cell.textLabel?.text = location.name
        }
            
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Open that location on the map
        if (trip?.locations!.count)! > 0 {
            let location = trip?.locations?[indexPath.row] as! Locations
            let openVC = OpenAddressVC()
            openVC.location = location
            self.navigationController?.pushViewController(openVC, animated: true)
        }
        else{
            // Open the map to add new waypoints if there's no points already.
            let mapVC = MapViewController()
            mapVC.trip = trip!
            self.navigationController?.pushViewController(mapVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // Don't delete if there's no locations.
        if (trip?.locations!.count)! > 0 {
            if editingStyle == .delete {
                let context = appDelegate.persistentContainer.viewContext
                // Delete location from list and data
                let location = trip?.locations?[indexPath.row] as! Locations
                trip?.removeFromLocations(location)
                do {
                    try context.save()
                }catch {
                    print(error)
                }
                
                tableView.reloadData()
            }
        }
    }
}
extension ChooseLocationVC: UITableViewDelegate {
// Not needed but will throw errors if not here.
}
