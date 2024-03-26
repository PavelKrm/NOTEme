//
//  AddLocationNotificationAssembler.swift
//  NoteMe
//
//  Created by PavelKrm on 27.02.24.
//

import UIKit
import Storage

final class AddLocationNotificationAssembler {
    
    private init() {}
    
    static func make(
        coordinator: AddLocationNotificationCoordinatorProtocol,
        container: Container,
        dto:LocationNotidicationDTO?
                        ) -> UIViewController {
                            
        let storage: LocationNotificationStorage = container.resolve()
        let fileService: FileService = container.resolve()
                            
        let vm = AddLocationNotificationVM(coordinator: coordinator,
                                           storage: storage,
                                           fileService: fileService,
                                           dto: dto)
                            
        return AddLocationNotificationVC(viewModel: vm)
    }
}
