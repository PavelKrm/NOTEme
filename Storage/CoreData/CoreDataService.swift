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
    
    lazy var mainContext: NSManagedObjectContext = {
            let context = persistentContainer.viewContext
            context.automaticallyMergesChangesFromParent = true
            return context
        }()
        
    var backgroundContext: NSManagedObjectContext {
            return persistentContainer.newBackgroundContext()
        }
    
    // MARK: - Core Data stack

    private var persistentContainer: NSPersistentContainer = {
        let modelName = "NotificationDataBase"
        let bundle = Bundle(for: CoreDataService.self)
            
        guard
            let modelURL = bundle.url(forResource: modelName,
                                      withExtension: "momd"),
            let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL)
        else { fatalError("unable to find model in bundle") }

            let container = NSPersistentContainer(
                name: modelName,
                managedObjectModel: managedObjectModel
            )
            
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

    func saveContext(context: NSManagedObjectContext,
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
