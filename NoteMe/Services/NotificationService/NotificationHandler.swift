//
//  NotificationHandler.swift
//  NoteMe
//
//  Created by PavelKrm on 2.04.24.
//

import Foundation
import Storage
import UserNotifications

final class NotificationHandler {
    
    private let storage = AllNotificationStorage()
    private let notificationCenter = UNUserNotificationCenter.current()
    
    func checkIsCompleted() {
        
        notificationCenter.getDeliveredNotifications { [weak self] in
            self?.setIsCompleted(notifications: $0)
        }
    }
    
    func setIsCompleted(notification: UNNotification) {
      
        let id = notification.request.identifier
        let date = notification.date
        
            var dto = storage
                .fetch(predicate: .Notification.notification(byId: id))
                .first
        
        dto?.completedDate = date
        guard let dto else { return }
        storage.update(dto: dto)
    }
    
    private func setIsCompleted(notifications: [UNNotification]) {
        let ids = notifications.map { $0.request.identifier }
        
        let dtos = storage
            .fetch(predicate: .Notification.notifications(in: ids))
            .map { dto in
                var updateDto = dto
                let date = notifications
                    .first { $0.request.identifier == dto.id }?
                    .date
                updateDto.completedDate = date
                return updateDto
            }
        storage.updateDtos(dtos: dtos)
    }
}
