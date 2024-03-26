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
    
    private weak var coordinator: AddDateNotificationCoordinatorProtocol?
    private let storage: DateNotificationStorage
    
    var targetDate: Date?
    var dto: DateNotificationDTO?
    
    init(coordinator: AddDateNotificationCoordinatorProtocol,
         storage: DateNotificationStorage,
         dto: DateNotificationDTO?) {
        self.coordinator = coordinator
        self.storage = storage
        self.dto = dto
    }
    
    func createNotification(title: String?,
                            subTitle: String) {
        
        guard
            let title, let targetDate
        else { return print("title or targetDate equal nil") }
        
        if let oldDto = dto {
            dto?.targetDate = targetDate
            dto?.title = title
            dto?.subtitle = subTitle
            
            storage.updateOrCreate(dto: oldDto)
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
            coordinator?.finish()
        }
    }
    
    func cancelDidTap() {
        coordinator?.finish()
    }
}
