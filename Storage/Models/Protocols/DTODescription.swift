//
//  DTODescription.swift
//  Storage
//
//  Created by PavelKrm on 7.02.24.
//

import Foundation
import CoreData

public protocol DTODescription {
    associatedtype DTO
    associatedtype MO: NSManagedObject, NSFetchRequestResult
    
    init?(mo: MO)
}
