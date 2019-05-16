//
//  CoreDataManager.swift
//  TimosTravel
//
//  Created by timofey makhlay on 5/15/19.
//  Copyright © 2019 Timofey Makhlay. All rights reserved.
//

import UIKit
import CoreData

class CoreDataFunc {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    /// Save a Trip to CoreData by providing a string
    /// - parameter name: Name of the Trip [String]
    func saveTrip(name:String) {
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Trips", in: context)
        let newTrip = NSManagedObject(entity: entity!, insertInto: context)
        
        newTrip.setValue(name, forKey: "name")

        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }
    
    /// Will return all the Trips saved to core data in an array.
    func readTrips() -> [Trips] {
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<Trips>(entityName: "Trips")
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            return result
        } catch {
            print("Failed")
            return []
        }
    }
}
