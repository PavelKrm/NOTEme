//
//  LocationNotificationDTO.swift
//  Storage
//
//  Created by PavelKrm on 9.02.24.
//

import Foundation

public final class LocationNotificationDTO: DTODescription {
    
    public typealias DTO = LocationNotificationDTO
    public typealias MO = LocationNotidicationMO
    
    public var date: Date
    public var id: String
    public var subtitle: String?
    public var title: String?
    public var completedDate: Date?
    public var longitude: Double
    public var latitude: Double
    public var imagePath: String
    
    public init(date: Date,
                id: String,
                subtitle: String? = nil,
                title: String? = nil,
                completedDate: Date? = nil,
                longitude: Double,
                latitude: Double,
                imagePath: String) {
        self.date = date
        self.id = id
        self.subtitle = subtitle
        self.title = title
        self.completedDate = completedDate
        self.longitude = longitude
        self.latitude = latitude
        self.imagePath = imagePath
    }
    
    public init?(mo: LocationNotidicationMO) {
        guard
            let date = mo.date,
            let id = mo.identifier,
            let subtitle = mo.subtitle,
            let title = mo.title,
            let completedDate = mo.completedDate,
            let imagePath = mo.imagePath
        else { return nil }
        
        self.date = date
        self.id = id
        self.subtitle = subtitle
        self.title = title
        self.completedDate = completedDate
        self.longitude = mo.longitude
        self.latitude = mo.latitude
        self.imagePath = imagePath
    }
}
