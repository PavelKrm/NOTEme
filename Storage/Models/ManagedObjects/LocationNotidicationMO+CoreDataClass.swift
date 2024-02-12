//
//  LocationNotidicationMO+CoreDataClass.swift
//  Storage
//
//  Created by PavelKrm on 7.02.24.
//
//

import Foundation
import CoreData

@objc(LocationNotidicationMO)
public class LocationNotidicationMO: BaseNotificationMO, MODescription {
    
    public typealias DTO = LocationNotificationDTO
    
    public func apply(dto: DTO) {
        
        self.date = dto.date
        self.identifier = dto.id
        self.subtitle = dto.subtitle
        self.title = dto.title
        self.completedDate = dto.completedDate
        self.longitude = dto.longitude
        self.latitude = dto.latitude
        self.imagePath = dto.imagePath
    }

}
