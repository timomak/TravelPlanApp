//
//  Locations+CoreDataProperties.swift
//  
//
//  Created by timofey makhlay on 5/15/19.
//
//

import Foundation
import CoreData


extension Locations {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Locations> {
        return NSFetchRequest<Locations>(entityName: "Locations")
    }

    @NSManaged public var alt: Double
    @NSManaged public var lat: Double
    @NSManaged public var name: String?
    @NSManaged public var trip: Trips?

}
