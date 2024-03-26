//
//  LocationNotidicationMO+CoreDataClass.swift
//  Storage
//
//  Created by PavelKrm on 7.02.24.
//
//

import Foundation
import CoreData

@objc(LocationNotidicationMO)
public class LocationNotidicationMO: BaseNotificationMO  {
    
    public override func toDTO() -> (any DTODescription)? {
        return LocationNotidicationDTO.fromMO(self)
    }
    
    public override func apply(dto: any DTODescription) {
        guard let dto = dto as? LocationNotidicationDTO
        else {
            print("[MODTO]", "\(Self.self) apply failed: dto is type of \(type(of: dto))")
            return
        }
        super.apply(dto: dto)
        
        self.latCenter = dto.latCenter
        self.longCenter = dto.longCenter
        self.latSpan = dto.latSpan
        self.longSpan = dto.longSpan
        self.imagePath = dto.imagePathStr
    }
}
