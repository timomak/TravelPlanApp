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
    @NSManaged public var locations: NSOrderedSet?

}

// MARK: Generated accessors for locations
extension Trips {

    @objc(insertObject:inLocationsAtIndex:)
    @NSManaged public func insertIntoLocations(_ value: Locations, at idx: Int)

    @objc(removeObjectFromLocationsAtIndex:)
    @NSManaged public func removeFromLocations(at idx: Int)

    @objc(insertLocations:atIndexes:)
    @NSManaged public func insertIntoLocations(_ values: [Locations], at indexes: NSIndexSet)

    @objc(removeLocationsAtIndexes:)
    @NSManaged public func removeFromLocations(at indexes: NSIndexSet)

    @objc(replaceObjectInLocationsAtIndex:withObject:)
    @NSManaged public func replaceLocations(at idx: Int, with value: Locations)

    @objc(replaceLocationsAtIndexes:withLocations:)
    @NSManaged public func replaceLocations(at indexes: NSIndexSet, with values: [Locations])

    @objc(addLocationsObject:)
    @NSManaged public func addToLocations(_ value: Locations)

    @objc(removeLocationsObject:)
    @NSManaged public func removeFromLocations(_ value: Locations)

    @objc(addLocations:)
    @NSManaged public func addToLocations(_ values: NSOrderedSet)

    @objc(removeLocations:)
    @NSManaged public func removeFromLocations(_ values: NSOrderedSet)

}
