//
//  AddDateNotificationVM.swift
//  NoteMe
//
//  Created by PavelKrm on 27.02.24.
//

import UIKit
import Storage

protocol AddDateNotificationCoordinatorProtocol: AnyObject {
    
    func finish()
}

final class AddDateNotificationVM: AddDateNotificationViewModelProtocol {
    
    var targetDate: Date?
    var dto: DateNotificationDTO?
    var catchEditDto: ((DateNotificationDTO) -> Void)?
    
    private weak var coordinator: AddDateNotificationCoordinatorProtocol?
    private let storage: DateNotificationStorage
    private let notification: NotificationService
    private var backupService: FirebaseBackupService
    
    init(coordinator: AddDateNotificationCoordinatorProtocol,
         storage: DateNotificationStorage,
         notification: NotificationService,
         backupService: FirebaseBackupService,
         dto: DateNotificationDTO?) {
        self.coordinator = coordinator
        self.storage = storage
        self.notification = notification
        self.backupService = backupService
        self.dto = dto
    }
    
    func viewDidLoad() {
        guard let dto else { return }
        catchEditDto?(dto)
    }
    
    func createNotification(title: String?,
                            subTitle: String) {
        
        guard
            let title, let targetDate
        else { return print("title or targetDate equal nil") }
        
        if var dto {
            dto.targetDate = targetDate
            dto.title = title
            dto.subtitle = subTitle
            
            storage.updateOrCreate(dto: dto)
            notification.createNotification(dto: dto)
            backupService.backup(dto: dto)
            coordinator?.finish()
        } else {
            let NewNotification = DateNotificationDTO.init(
                                                date: Date(),
                                                id: UUID().uuidString,
                                                title: title,
                                                subtitle: subTitle,
                                                targetDate: targetDate
                                                            )
        
            storage.updateOrCreate(dto: NewNotification, completion: nil)
            notification.createNotification(dto: NewNotification)
            backupService.backup(dto: NewNotification)
            coordinator?.finish()
        }
    }
    
    func cancelDidTap() {
        coordinator?.finish()
    }
}
