//
//  LocationNotificationStorage.swift
//  Storage
//
//  Created by PavelKrm on 9.02.24.
//

import CoreData

public final class LocationNotificationStorage: NotificationStorage<LocationNotificationDTO> {
    
    public typealias CompletionHandler = (Bool) -> Void
    
    public override init() {}
    
    //Fetch
    public override func fetch(
        predicate: NSPredicate? = nil,
        sortDescriptors: [NSSortDescriptor] = []
    ) -> [LocationNotificationDTO] {
        return fetchMO(predicate: predicate,
                     sortDescriptors: sortDescriptors)
        .compactMap { LocationNotificationDTO(mo: $0) }
    }
    
    private func fetchMO(
        predicate: NSPredicate? = nil,
        sortDescriptors: [NSSortDescriptor] = []
    ) -> [LocationNotidicationMO] {
        let request: NSFetchRequest<LocationNotidicationMO> = LocationNotidicationMO.fetchRequest()
        let context = CoreDataService.shared.mainContext
        let results = try? context.fetch(request)
        return results ?? []
    }
    
    //Create
    public override func create(
        dto: LocationNotificationDTO,
        completion: CompletionHandler? = nil
    ) {
        let context = CoreDataService.shared.backgroundContext
        context.perform {
            let mo = LocationNotidicationMO(context: context)
            mo.apply(dto: dto)
            
            CoreDataService.shared.saveContext(context: context,
                                               completion: completion)
        }
    }
    //Update
    public func update(
        dto: LocationNotificationDTO,
        completion: CompletionHandler? = nil
    ) {
        let context = CoreDataService.shared.backgroundContext
        context.perform { [weak self] in
            guard
                let mo = self?.fetchMO(
                    predicate: .Notification.notification(byId: dto.id)
                ).first
            else { return }
            mo.apply(dto: dto)
            
            CoreDataService.shared.saveContext(context: context,
                                               completion: completion)
        }
    }
    //UpdateOrCreate
    public func updateOrCreate(
        dto: LocationNotificationDTO,
        completion: CompletionHandler? = nil
    ) {
        if fetchMO(predicate: .Notification.notification(byId: dto.id)).isEmpty {
            create(dto: dto, completion: completion)
        } else {
            update(dto: dto, completion: completion)
        }
    }
}
