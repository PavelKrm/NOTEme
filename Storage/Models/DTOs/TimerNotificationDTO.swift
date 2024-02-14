//
//  TimerNotificationDTO.swift
//  Storage
//
//  Created by PavelKrm on 9.02.24.
//

import Foundation

public final class TimerNotificationDTO: DTODescription {
    
    public typealias DTO = TimerNotificationDTO
    public typealias MO = TimerNotificationMO
    
    public var date: Date
    public var id: String
    public var subtitle: String?
    public var title: String?
    public var completedDate: Date?
    public var timeLeft: Date?
    
    public init(date: Date,
                id: String,
                subtitle: String? = nil,
                title: String? = nil,
                completedDate: Date? = nil,
                timeLeft: Date? = nil) {
        self.date = date
        self.id = id
        self.subtitle = subtitle
        self.title = title
        self.completedDate = completedDate
        self.timeLeft = timeLeft
    }
    
    public init?(mo: TimerNotificationMO) {
        guard
            let date = mo.date,
            let id = mo.identifier,
            let subtitle = mo.subtitle,
            let title = mo.title,
            let completedDate = mo.completedDate,
            let timeLeft = mo.timeLeft
        else { return nil }
        
        self.date = date
        self.id = id
        self.subtitle = subtitle
        self.title = title
        self.completedDate = completedDate
        self.timeLeft = timeLeft
    }
}
