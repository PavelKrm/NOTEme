//
//  DateNotificationDTO.swift
//  Storage
//
//  Created by PavelKrm on 30.01.24.
//

import Foundation

public struct DateNotificationDTO: DTODescription {
    typealias DTO = Self
    typealias MO = DateNotificationMO
    
    public var date: Date
    public var id: String
    public var subtitle: String?
    public var title: String?
    public var completedDate: Date?
    public var targetDate: Date
    
    init(date: Date,
         id: String,
         subtitle: String? = nil,
         title: String? = nil,
         completedDate: Date? = nil,
         targerDate: Date) {
        
        self.date = date
        self.id = id
        self.subtitle = subtitle
        self.title = title
        self.completedDate = completedDate
        self.targetDate = targerDate
    }
    
    init?(mo: DateNotificationMO) {
        guard
            let id = mo.identifier,
            let title = mo.title,
            let date = mo.date,
            let targetDate = mo.targetDate
        else { return nil }
        
        self.date = date
        self.id = id
        self.title = title
        self.subtitle = mo.subtitle
        self.completedDate = mo.completedDate
        self.targetDate = targetDate
                
    }
}
