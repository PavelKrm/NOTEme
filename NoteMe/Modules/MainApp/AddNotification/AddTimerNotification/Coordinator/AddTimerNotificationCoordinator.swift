//
//  AddTimerNotificationCoordinator.swift
//  NoteMe
//
//  Created by PavelKrm on 27.02.24.
//

import UIKit
import Storage

final class AddTimerNotificationCoordinator: Coordinator {

    private let container: Container
    private let dto: TimerNotificationDTO?
    
    init(container: Container,
         dto: TimerNotificationDTO? = nil) {
        self.container = container
        self.dto = dto
    }
    
    override func start() -> UIViewController {
        
        return AddTimerNotificationAssembler.make(coordinator: self,
                                                  container: container,
                                                  dto: dto)
    }
}

extension AddTimerNotificationCoordinator: AddTimerNotificationCoordinatorProtocol {}
