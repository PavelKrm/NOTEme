//
//  CoreDataService.swift
//  Storage
//
//  Created by PavelKrm on 30.01.24.
//

import CoreData

final class CoreDataService {
    
    static let shared: CoreDataService = .init()
    
    typealias SuccessHandler = (Bool) -> Void
    
    var mainContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // MARK: - Core Data stack

    var persistentContainer: NSPersistentContainer = {
       
        let container = NSPersistentContainer(name: "NotificationDataBase")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
               
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext (completion: SuccessHandler?) {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                completion?(true)
            } catch {
                completion?(false)
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
