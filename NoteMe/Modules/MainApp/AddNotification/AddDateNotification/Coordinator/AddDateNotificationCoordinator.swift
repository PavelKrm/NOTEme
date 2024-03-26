//
//  AddDateNotificationCoordinator.swift
//  NoteMe
//
//  Created by PavelKrm on 27.02.24.
//

import UIKit
import Storage

final class AddDateNotificationCoordinator: Coordinator {

    private let container: Container
    private let dto: DateNotificationDTO?
    
    init(container: Container,
         dto: DateNotificationDTO? = nil) {
        self.container = container
        self.dto = dto
    }
    
    override func start() -> UIViewController {
        
        return AddDateNotificationAssembler.make(coordinator: self,
                                                 container: container,
                                                 dto: dto)
    }
}

extension AddDateNotificationCoordinator: AddDateNotificationCoordinatorProtocol {}
