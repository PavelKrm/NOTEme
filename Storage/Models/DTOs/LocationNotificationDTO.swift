//
//  LocationNotificationDTO.swift
//  Storage
//
//  Created by PavelKrm on 9.02.24.
//

import Foundation
import CoreData

public struct LocationNotidicationDTO: DTODescription {
    public typealias MO = LocationNotidicationMO
    
    public var date: Date
    public var id: String
    public var title: String
    public var subtitle: String?
    public var completedDate: Date?
    public var latSpan: Double
    public var longSpan: Double
    public var latCenter: Double
    public var longCenter: Double
    public var imagePathStr: String
    
    public init(date: Date,
                id: String = UUID().uuidString,
                title: String,
                subtitle: String? = nil,
                completedDate: Date? = nil,
                latSpan: Double,
                longSpan: Double,
                latCenter: Double,
                longCenter: Double,
                imagePathStr: String) {
        self.date = date
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.completedDate = completedDate
        self.latSpan = latSpan
        self.longSpan = longSpan
        self.latCenter = latCenter
        self.longCenter = longCenter
        self.imagePathStr = imagePathStr
    }
    
    public static func fromMO(_ mo: LocationNotidicationMO) -> LocationNotidicationDTO? {
        guard
            let date = mo.date,
            let id = mo.identifier,
            let title = mo.title,
            let imagePathStr = mo.imagePath
        else { return nil }
        
        return LocationNotidicationDTO(
            date: date,
            id: id,
            title: title,
            subtitle: mo.subtitle,
            completedDate: mo.completedDate,
            latSpan: mo.latSpan,
            longSpan: mo.longSpan,
            latCenter: mo.latCenter,
            longCenter: mo.longCenter,
            imagePathStr: imagePathStr
        )
    }
}
