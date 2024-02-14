//
//  TimerNotificationStorage.swift
//  Storage
//
//  Created by PavelKrm on 9.02.24.
//

import CoreData

public final class TimerNotificationStorage: NotificationStorage<TimerNotificationDTO> {
    
//    public typealias CompletionHandler = (Bool) -> Void
//    
//    public override init() {}
//    
//    //Fetch
//    public override func fetch(
//        predicate: NSPredicate? = nil,
//        sortDescriptors: [NSSortDescriptor] = []
//    ) -> [TimerNotificationDTO] {
//        return fetchMO(predicate: predicate,
//                     sortDescriptors: sortDescriptors)
//        .compactMap { TimerNotificationDTO(mo: $0) }
//    }
//    
//    private func fetchMO(
//        predicate: NSPredicate? = nil,
//        sortDescriptors: [NSSortDescriptor] = []
//    ) -> [TimerNotificationMO] {
//        let request: NSFetchRequest<TimerNotificationMO> = TimerNotificationMO.fetchRequest()
//        let context = CoreDataService.shared.mainContext
//        let results = try? context.fetch(request)
//        return results ?? []
//    }
//    
//    //Create
//    public override func create(
//        dto: TimerNotificationDTO,
//        completion: CompletionHandler? = nil
//    ) {
//        let context = CoreDataService.shared.backgroundContext
//        context.perform {
//            let mo = TimerNotificationMO(context: context)
//            mo.apply(dto: dto)
//            
//            CoreDataService.shared.saveContext(context: context,
//                                               completion: completion)
//        }
//    }
//    //Update
//    public func update(
//        dto: TimerNotificationDTO,
//        completion: CompletionHandler? = nil
//    ) {
//        let context = CoreDataService.shared.backgroundContext
//        context.perform { [weak self] in
//            guard
//                let mo = self?.fetchMO(
//                    predicate: .Notification.notification(byId: dto.id)
//                ).first
//            else { return }
//            mo.apply(dto: dto)
//            
//            CoreDataService.shared.saveContext(context: context,
//                                               completion: completion)
//        }
//    }
//    //UpdateOrCreate
//    public func updateOrCreate(
//        dto: TimerNotificationDTO,
//        completion: CompletionHandler? = nil
//    ) {
//        if fetchMO(predicate: .Notification.notification(byId: dto.id)).isEmpty {
//            create(dto: dto, completion: completion)
//        } else {
//            update(dto: dto, completion: completion)
//        }
//    }
}
