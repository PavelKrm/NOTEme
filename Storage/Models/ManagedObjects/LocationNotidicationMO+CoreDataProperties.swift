//
//  LocationNotidicationMO+CoreDataProperties.swift
//  Storage
//
//  Created by PavelKrm on 25.03.24.
//
//

import Foundation
import CoreData


extension LocationNotidicationMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LocationNotidicationMO> {
        return NSFetchRequest<LocationNotidicationMO>(entityName: "LocationNotidicationMO")
    }

    @NSManaged public var imagePath: String?
    @NSManaged public var latCenter: Double
    @NSManaged public var longCenter: Double
    @NSManaged public var longSpan: Double
    @NSManaged public var latSpan: Double

}
