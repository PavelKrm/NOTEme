//
//  LocationNotidicationMO+CoreDataProperties.swift
//  Storage
//
//  Created by PavelKrm on 7.02.24.
//
//

import Foundation
import CoreData


extension LocationNotidicationMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LocationNotidicationMO> {
        return NSFetchRequest<LocationNotidicationMO>(entityName: "LocationNotidicationMO")
    }

    @NSManaged public var imagePath: String?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double

}
