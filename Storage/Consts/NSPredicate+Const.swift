//
//  NSPredicate+Const.swift
//  Storage
//
//  Created by PavelKrm on 30.01.24.
//

import CoreData

extension NSPredicate {
    
    enum Notification {
        static func notification(byId id: String) -> NSPredicate {
            let idKeypath = #keyPath(BaseNotificationMO.identifier)
            return .init(format: "\(idKeypath) CONTAINS[cd] %@", id)
        }
    }
    
//    enum Notification {
//        static func notification(
//            byId id: String,
//            with keyPath: KeyPath<Any, Any>
//        ) -> NSPredicate {
//            return .init(format: "\(keyPath) CONTAINS[cd] %@", id)
//        }
//    }
}
