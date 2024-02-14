//
//  AddNotificationVM.swift
//  NoteMe
//
//  Created by PavelKrm on 13.02.24.
//

import UIKit

protocol AddNotificationCoordinator: AnyObject {
    
}

final class AddNotificationVM: AddNotificationViewModelProtocol {
    
    var typeNotification: AddNotification
    
    private weak var coordinator: AddNotificationCoordinator?
    
    init(typeNotification: AddNotification,
         coordinator: AddNotificationCoordinator) {
        self.typeNotification = typeNotification
        self.coordinator = coordinator
    }
    
    func createNotification(_ type: AddNotification,
                            title: String,
                            targetDate: Date?,
                            subTitle: String,
                            longitude: Double?,
                            latitude: Double?,
                            imagePath: String?) {
        
    }
    
    func createNotification() {}
    
    func cancelDidTap() {}
}
