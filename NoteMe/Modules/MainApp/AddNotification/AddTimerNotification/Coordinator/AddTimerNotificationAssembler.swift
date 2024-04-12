//
//  AddTimerNotificationAssembler.swift
//  NoteMe
//
//  Created by PavelKrm on 27.02.24.
//

import UIKit
import Storage

final class AddTimerNotificationAssembler {
    
    private init() {}
    
    static func make(coordinator: AddTimerNotificationCoordinatorProtocol,
                     container: Container,
                     dto: TimerNotificationDTO?) -> UIViewController {

        let storage: TimerNotificationStorage = container.resolve()
        let notificationService: NotificationService = container.resolve()
        let backup: FirebaseBackupService = container.resolve()
        
        let vm = AddTimerNotificationVM(coordinator: coordinator,
                                        storage: storage,
                                        notification: notificationService,
                                        backupService: backup,
                                        dto: dto)
                            
        return AddTimerNotificationVC(viewModel: vm)
    }
}
