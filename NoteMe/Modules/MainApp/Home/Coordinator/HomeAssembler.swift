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
    
    static func make() -> UIViewController {
        
        let vm = HomeVM(frcService: makeFRC(),
                        adapter: HomeAdapter())
        return HomeVC(viewModel: vm)
    }
    
    private static func makeFRC() -> FRCService<BaseNotificationDTO> {
        return .init { request in
            request.predicate = .Notification.allNotComleted
            request.sortDescriptors = [.Notification.byDate]
        }
    }
}


