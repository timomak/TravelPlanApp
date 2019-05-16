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
    
//    func returnAllLocationsForTrip(trip:Trips) -> [Locations] {
//        let context = appDelegate.persistentContainer.viewContext
//        let myFetch:NSFetchRequest<Locations> = context.fetchRequest()
//        let myPredicate = NSPredicate(format: "Trips-relationship == %@", (myTransferdObject?.name!)!)
//        myFetch.predicate = myPredicate
//        do {
//            usersList = try myContext.fetch(myFetch)
//        }catch{
//            print(error)
//        }
//    }
    
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
    
    func readAllLocations() {
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Locations")
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                print("Reading All:", data.value(forKey: "name") as! String)
            }
            
        } catch {
            
            print("Failed")
        }
    }
    
    func deleteTrip() {
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
        do {
            var result = try context.fetch(request) as! [NSManagedObject]
            for item in result {
                context.delete(item)
            }
            do {
                try context.save()
            }
            catch {
                print(error)
            }
        } catch {
            
            print("Failed")
        }
        
    }
}
