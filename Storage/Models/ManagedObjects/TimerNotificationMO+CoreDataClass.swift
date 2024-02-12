//
//  TimerNotificationMO+CoreDataClass.swift
//  Storage
//
//  Created by PavelKrm on 7.02.24.
//
//

import Foundation
import CoreData

@objc(TimerNotificationMO)
public class TimerNotificationMO: BaseNotificationMO, MODescription {
    
    public typealias DTO = TimerNotificationDTO

    public func apply(dto: DTO) {
        
        self.date = dto.date
        self.identifier = dto.id
        self.subtitle = dto.subtitle
        self.title = dto.title
        self.completedDate = dto.completedDate
        self.timeLeft = dto.timeLeft
    }
}
