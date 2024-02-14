//
//  DateNotificationDTO.swift
//  Storage
//
//  Created by PavelKrm on 30.01.24.
//

import Foundation

public final class DateNotificationDTO: DTODescription {

    public typealias DTO = DateNotificationDTO
    public typealias MO = DateNotificationMO
    
    public var date: Date
    public var id: String
    public var subtitle: String?
    public var title: String?
    public var completedDate: Date?
    public var targetDate: Date
    
    public init(date: Date,
                identifier: String,
                subtitle: String? = nil,
                title: String? = nil,
                completedDate: Date? = nil,
                targerDate: Date) {
        
        self.date = date
        self.id = identifier
        self.subtitle = subtitle
        self.title = title
        self.completedDate = completedDate
        self.targetDate = targerDate
    }
    
    public init?(mo: DateNotificationMO) {
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
