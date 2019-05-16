//
//  Trips+CoreDataProperties.swift
//  
//
//  Created by timofey makhlay on 5/15/19.
//
//

import Foundation
import CoreData


extension Trips {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Trips> {
        return NSFetchRequest<Trips>(entityName: "Trips")
    }

    @NSManaged public var name: String?
    @NSManaged public var locations: NSSet?

}

// MARK: Generated accessors for locations
extension Trips {

    @objc(addLocationsObject:)
    @NSManaged public func addToLocations(_ value: Locations)

    @objc(removeLocationsObject:)
    @NSManaged public func removeFromLocations(_ value: Locations)

    @objc(addLocations:)
    @NSManaged public func addToLocations(_ values: NSSet)

    @objc(removeLocations:)
    @NSManaged public func removeFromLocations(_ values: NSSet)

}
