//
//  BaseNotificationMO+CoreDataClass.swift
//  Storage
//
//  Created by PavelKrm on 30.01.24.
//
//

import Foundation
import CoreData

@objc(BaseNotificationMO)
public class BaseNotificationMO: NSManagedObject, MODescription {
    public func toDTO() -> (any DTODescription)? {
        return BaseNotificationDTO.fromMO(self)
    }
    
    public func apply(dto: any DTODescription) {
        
        self.identifier = dto.id
        self.date = dto.date
        self.title = dto.title
        self.subtitle = dto.subtitle
        self.completedDate = dto.completedDate
    }
}
