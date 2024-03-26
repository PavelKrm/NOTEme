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
        let vm = AddTimerNotificationVM(coordinator: coordinator,
                                        storage: storage,
                                        dto: dto)
                            
        return AddTimerNotificationVC(viewModel: vm)
    }
}
