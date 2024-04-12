//
//  AddDateNotificationAssembler.swift
//  NoteMe
//
//  Created by PavelKrm on 27.02.24.
//

import UIKit
import Storage

final class AddDateNotificationAssembler {
    
    private init() {}
    
    static func make(
        coordinator: AddDateNotificationCoordinatorProtocol,
        container: Container,
        dto: DateNotificationDTO?
                        ) -> UIViewController {
                            
        let storage: DateNotificationStorage = container.resolve()
        let notificationService: NotificationService = container.resolve()
        let backup: FirebaseBackupService = container.resolve()
                            
        let vm = AddDateNotificationVM(coordinator: coordinator,
                                       storage: storage,
                                       notification: notificationService,
                                       backupService: backup,
                                       dto: dto)
                            
        return AddDateNotificationVC(viewModel: vm)
    }
}
