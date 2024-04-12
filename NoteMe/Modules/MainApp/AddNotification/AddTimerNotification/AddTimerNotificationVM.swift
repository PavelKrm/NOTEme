//
//  AddTimerNotificationVM.swift
//  NoteMe
//
//  Created by PavelKrm on 27.02.24.
//

import UIKit
import Storage

protocol AddTimerNotificationCoordinatorProtocol: AnyObject {
    
    func finish()
}

final class AddTimerNotificationVM: AddTimerNotificationViewModelProtocol {
    
    
    var timeLeft: Int? {
        didSet {
            if let time = timeLeft {
                
                let hour = time / 3600
                let hourStr = hour > 9 ? "\(hour)" : "0\(hour)"
                let minutes = time / 60 - hour * 60
                let minutesStr = minutes > 9 ? "\(minutes)" : "0\(minutes)"
                
                cachTime?("\(hourStr):\(minutesStr):00")
            }
        }
    }
    var subtitle: String?
    var cachTime: ((String) -> Void)?
    var dto: TimerNotificationDTO?
    
    private weak var coordinator: AddTimerNotificationCoordinatorProtocol?
    private let storage: TimerNotificationStorage
    private let nortification: NotificationService
    private var backupService: FirebaseBackupService
    
    init(coordinator: AddTimerNotificationCoordinatorProtocol,
         storage: TimerNotificationStorage,
         notification: NotificationService,
         backupService: FirebaseBackupService,
         dto: TimerNotificationDTO?) {
        self.coordinator = coordinator
        self.storage = storage
        self.nortification = notification
        self.backupService = backupService
        self.dto = dto
    }
    
    func createNotification(title: String?) {
        
        guard
            let title, let timeLeft, let subtitle
        else { return }
        
        if var dto {
            dto.title = title
            dto.subtitle = subtitle
            dto.timeLeft = timeLeft
            storage.updateOrCreate(dto: dto)
            nortification.createNotification(dto: dto)
            backupService.backup(dto: dto)
            coordinator?.finish()
        } else {
            let NewNotification = TimerNotificationDTO.init(
                                                date: Date(),
                                                id: UUID().uuidString,
                                                subtitle: subtitle,
                                                title: title,
                                                timeLeft: timeLeft
                                                            )
        
            storage.updateOrCreate(dto: NewNotification, completion: nil)
            nortification.createNotification(dto: NewNotification)
            backupService.backup(dto: NewNotification)
            coordinator?.finish()
        }
    }
    
    func cancelDidTap() {
        coordinator?.finish()
    }
}
