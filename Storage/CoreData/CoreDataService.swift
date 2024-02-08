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
    
    var backgroundContext: NSManagedObjectContext {
        let context = persistentContainer.newBackgroundContext()
        context.parent = mainContext
        return context
    }
    
    // MARK: - Core Data stack

    var persistentContainer: NSPersistentContainer = {
       
        let modelName = "NotificationDataBase"
        let bundle = Bundle(for: CoreDataService.self)
        guard
            let modelURL = bundle.url(forResource: modelName, withExtension: "momd"),
            let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL)
        else { fatalError() }
        
        let container = NSPersistentContainer(name: "NotificationDataBase")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
               
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    
    func saveMainContext(completion: SuccessHandler? = nil) {
        saveContext(context: mainContext, completion: completion)
    }

    func saveContext (context: NSManagedObjectContext,
                      completion: SuccessHandler?) {
       
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
