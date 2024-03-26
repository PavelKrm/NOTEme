//
//  TimerNotificationMO+CoreDataClass.swift
//  Storage
//
//  Created by PavelKrm on 7.02.24.
//
//

import Foundation
import CoreData

@objc(TimerNotificationMO)
public class TimerNotificationMO: BaseNotificationMO {
    
    public override func toDTO() -> (any DTODescription)? {
        return TimerNotificationDTO.fromMO(self)
    }
    
    public override func apply(dto: any DTODescription) {
        guard let dto = dto as? TimerNotificationDTO
        else {
            print("[MODTO]", "\(Self.self) apply failed: dto is type of \(type(of: dto))")
            return
        }
        super.apply(dto: dto)
        
        self.timeLeft = Double(dto.timeLeft)
    }
}
