//
//  DateNotificationStorage.swift
//  Storage
//
//  Created by PavelKrm on 30.01.24.
//

import CoreData

public final class DateNotificationStorage: NotificationStorage<DateNotificationDTO> {
    
    public typealias CompletionHandler = (Bool) -> Void
    
    public override init() {}
    
    //Fetch
    public override func fetch(
        predicate: NSPredicate? = nil,
        sortDescriptors: [NSSortDescriptor] = []
    ) -> [DateNotificationDTO] {
        return fetchMO(predicate: predicate,
                     sortDescriptors: sortDescriptors)
        .compactMap { DateNotificationDTO(mo: $0) }
    }
    
    private func fetchMO(
        predicate: NSPredicate? = nil,
        sortDescriptors: [NSSortDescriptor] = []
    ) -> [DateNotificationMO] {
        let request: NSFetchRequest<DateNotificationMO> = DateNotificationMO.fetchRequest()
        let context = CoreDataService.shared.mainContext
        let results = try? context.fetch(request)
        return results ?? []
    }
    
    //Create
    public override func create(
        dto: DateNotificationDTO,
        completion: CompletionHandler? = nil
    ) {
        let context = CoreDataService.shared.backgroundContext
        context.perform {
            let mo = DateNotificationMO(context: context)
            mo.apply(dto: dto)
            
            CoreDataService.shared.saveContext(context: context,
                                               completion: completion)
        }
    }
    //Update
    public func update(
        dto: DateNotificationDTO,
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
        dto: DateNotificationDTO,
        completion: CompletionHandler? = nil
    ) {
        if fetchMO(predicate: .Notification.notification(byId: dto.id)).isEmpty {
            create(dto: dto, completion: completion)
        } else {
            update(dto: dto, completion: completion)
        }
    }
}
