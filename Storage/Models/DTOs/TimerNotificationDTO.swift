//
//  TimerNotificationDTO.swift
//  Storage
//
//  Created by PavelKrm on 9.02.24.
//

import Foundation

public struct TimerNotificationDTO: DTODescription {
    
    public typealias MO = TimerNotificationMO
    
    public var date: Date
    public var id: String
    public var subtitle: String?
    public var title: String
    public var completedDate: Date?
    public var timeLeft: Int
    
    public init(date: Date,
                id: String,
                subtitle: String? = nil,
                title: String,
                completedDate: Date? = nil,
                timeLeft: Int) {
        self.date = date
        self.id = id
        self.subtitle = subtitle
        self.title = title
        self.completedDate = completedDate
        self.timeLeft = timeLeft
    }
    
    public static func fromMO(_ mo: TimerNotificationMO) -> TimerNotificationDTO? {
        guard
            let date = mo.date,
            let id = mo.identifier,
            let subtitle = mo.subtitle,
            let title = mo.title,
            let completedDate = mo.completedDate
        else { return nil }
        
        return TimerNotificationDTO(
                    date: date,
                    id: id,
                    subtitle: subtitle,
                    title: title,
                    completedDate: completedDate,
                    timeLeft: Int(mo.timeLeft)
                )

    }
}
