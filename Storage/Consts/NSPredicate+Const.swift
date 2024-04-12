//
//  NSPredicate+Const.swift
//  Storage
//
//  Created by PavelKrm on 30.01.24.
//

import CoreData

public extension NSPredicate {
    
    enum Notification {
        
        public static var allNotComleted: NSPredicate {
            let comletedDateKeypath = #keyPath(BaseNotificationMO.completedDate)
            return .init(format: "\(comletedDateKeypath) == NULL")
        }
        
        public static func notification(byId id: String) -> NSPredicate {
            let idKeypath = #keyPath(BaseNotificationMO.identifier)
            return .init(format: "\(idKeypath) CONTAINS[cd] %@", id)
        }
        
        public static func notifications(in ids: [String]) -> NSPredicate {
            let idKeypath = #keyPath(BaseNotificationMO.identifier)
            return NSCompoundPredicate(andPredicateWithSubpredicates: [
                .init(format: "\(idKeypath) IN %@", ids),
                allNotComleted
            ])
        }
    }
}
