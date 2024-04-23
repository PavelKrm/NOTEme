//
//  HomeAssembler.swift
//  NoteMe
//
//  Created by PavelKrm on 29.11.23.
//

import UIKit
import Storage

final class HomeAssembler {
    
    private init() {}
    
    static func make(coordinator: HomeViewModelCoordinatorProtocol,
                     container: Container) -> UIViewController {
        
        let storage: AllNotificationStorage = container.resolve()
        
        let vm = HomeVM(frcService: makeFRC(),
                        adapter: HomeAdapter(),
                        coordinator: coordinator,
                        storage: storage)
        return HomeVC(viewModel: vm)
    }
    
    private static func makeFRC() -> FRCService<BaseNotificationDTO> {
        return .init { request in
            request.predicate = .Notification.allNotComleted
            request.sortDescriptors = [.Notification.byDate]
        }
    }
}


