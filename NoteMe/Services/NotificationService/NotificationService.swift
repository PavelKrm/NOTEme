//
//  NotificationService.swift
//  NoteMe
//
//  Created by PavelKrm on 2.04.24.
//

import UIKit
import MapKit
import Storage

final class NotificationService {
    
    private let service = UNUserNotificationCenter.current()
    
    func createNotification(circle: CLCircularRegion? = nil,
                                           dto: any DTODescription) {
        
        switch dto {
        case is DateNotificationDTO:
            createDateNotification(dto: dto as! DateNotificationDTO)
        case is TimerNotificationDTO:
            createTimerNotification(dto: dto as! TimerNotificationDTO)
        case is LocationNotidicationDTO:
            guard let circle else { return }
            createLocationNotification(dto: dto as! LocationNotidicationDTO,
                                       circle: circle)
        default: break
        }
        
    }
    
    func deleteNotification(dto: any DTODescription) {
        service.removeDeliveredNotifications(withIdentifiers: [dto.id])
        service.removePendingNotificationRequests(withIdentifiers: [dto.id])
    }
    
    private func createDateNotification(dto: DateNotificationDTO) {
        
        let components = Calendar.current.dateComponents(in: TimeZone.current,
                                                         from: dto.targetDate)
        var matching = DateComponents()
        matching.year = components.year
        matching.month = components.month
        matching.hour = components.hour
        matching.minute = components.minute
        matching.second = components.second
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: matching,
                                                    repeats: false)
        setRequest(dto: dto, trigger: trigger)
    }
    
    private func createTimerNotification(dto: TimerNotificationDTO) {
        
        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: TimeInterval(dto.timeLeft),
            repeats: false
        )
        
        setRequest(dto: dto, trigger: trigger)
    }
    
    private func createLocationNotification(dto: LocationNotidicationDTO,
                                            circle: CLCircularRegion) {
        let trigger = UNLocationNotificationTrigger(region: circle,
                                                    repeats: false)
        setRequest(dto: dto, trigger: trigger)
    }
    
    private func getContent(dto: any DTODescription) -> UNMutableNotificationContent {
        
        let content = UNMutableNotificationContent()
        content.title = dto.title
        content.body = dto.subtitle ?? ""
        content.badge = NSNumber(1)
        
        return content
    }
    
    private func setRequest(dto: any DTODescription, trigger: UNNotificationTrigger) {
        
        let content = getContent(dto: dto)
        
        let request = UNNotificationRequest(identifier: dto.id,
                                            content: content,
                                            trigger: trigger)
        service.add(request)
    }
}
