//
//  LocationNotificationStorage.swift
//  Storage
//
//  Created by PavelKrm on 9.02.24.
//

import CoreData

public final class LocationNotificationStorage: NotificationStorage<LocationNotidicationDTO> {
    
    public func fetch(predicate: NSPredicate? = nil,
                      sortDescriptors: [NSSortDescriptor] = []
    ) -> [LocationNotidicationDTO] {
        return super.fetch(
        predicate: predicate,
        sortDescriptors: sortDescriptors
        ).compactMap { $0 as? LocationNotidicationDTO }
    }
}
