//
//  NotificationStorage.swift
//  Storage
//
//  Created by PavelKrm on 7.02.24.
//

import Foundation
import CoreData

public class NotificationStorage<DTO: DTODescription> {
    
    public typealias CompletionHandler = (Bool) -> Void
    
    public init() {}

//MARK: - Fetch
    
    public func fetch(
        predicate: NSPredicate? = nil,
        sortDescriptors: [NSSortDescriptor] = []
    ) -> [any DTODescription] {
        let context = CoreDataService.shared.backgroundContext
        return fetchMO(context: context,
                       predicate: predicate,
                       sortDescriptors: sortDescriptors)
        .compactMap { $0.toDTO() }
    }
    
//    MARK: - Create
    
    public func create(dto: any DTODescription,
                       completion: CompletionHandler? = nil
    ) {
        let context = CoreDataService.shared.backgroundContext
        context.perform {
            let mo = DTO.MO(context: context)
            mo.apply(dto: dto)
            CoreDataService.shared.saveContext(context: context,
                                               completion: completion)
        }
    }
    
//MARK: - Update
    
    public func update(
        dto: any DTODescription,
        completion: CompletionHandler? = nil
    ) {
        let context = CoreDataService.shared.backgroundContext
        context.perform { [weak self] in
            guard
                let mo = self?.fetchMO(
                    context: context,
                    predicate: .Notification.notification(byId: dto.id)
                ).first
            else { return }
            mo.apply(dto: dto)
            
            CoreDataService.shared.saveContext(context: context,
                                               completion: completion)
        }
    }

    public func updateOrCreate(
        dto: any DTODescription,
        completion: CompletionHandler? = nil
    ) {
        let context = CoreDataService.shared.backgroundContext
        if fetchMO(
            context: context,
            predicate: .Notification.notification(byId: dto.id)
        ).isEmpty {
            create(dto: dto, completion: completion)
        } else {
            update(dto: dto, completion: completion)
        }
    }
    
    public func updateDtos(dtos: [any DTODescription],
                           comletion: CompletionHandler? = nil) {
        
        let context = CoreDataService.shared.backgroundContext
        let ids = dtos.map { $0.id }
        
        context.perform { [weak self] in
            guard let mos = self?.fetchMO(
                context: context,
                predicate: .Notification.notifications(in: ids)
            )
            else { return }
            
            mos.forEach { model in
                guard
                    let dto = dtos.first(where: { $0.id == model.identifier })
                else { return }
                model.apply(dto: dto)
            }
            
            CoreDataService.shared.saveContext(context: context)
        }
    }
    
//MARK: - delete
    
    public func delete(dto: any DTODescription,
                       completion: CompletionHandler? = nil) {
        
    }
    
    private func fetchMO(
        context: NSManagedObjectContext,
        predicate: NSPredicate? = nil,
        sortDescriptors: [NSSortDescriptor] = []
    ) -> [DTO.MO] {
        let request = NSFetchRequest<DTO.MO>(entityName: "\(DTO.MO.self)")
        request.predicate = predicate
        request.sortDescriptors = sortDescriptors
        let results = try? context.fetch(request)
        return results ?? []
    }
    
}


