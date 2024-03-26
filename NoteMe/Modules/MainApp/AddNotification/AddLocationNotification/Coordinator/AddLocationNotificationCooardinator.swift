//
//  AddLocationNotificationCooardinator.swift
//  NoteMe
//
//  Created by PavelKrm on 27.02.24.
//

import UIKit
import Storage

final class AddLocationNotificationCooardinator: Coordinator {

    private var rootVC: UIViewController?
    private let container: Container
    private let dto: LocationNotidicationDTO?
    
    init(container: Container,
         dto: LocationNotidicationDTO? = nil) {
        self.container = container
        self.dto = dto
    }
    
    override func start() -> UIViewController {
        
        let vc = AddLocationNotificationAssembler.make(coordinator: self,
                                                       container: container,
                                                       dto: dto)
        rootVC = vc
        return vc
    }
}

extension AddLocationNotificationCooardinator: AddLocationNotificationCoordinatorProtocol {
    
    func openMap(delegate: MapDelegate, dto: LocationNotidicationDTO) {
        
        let coordinator = MapCoordinator(container: container,
                                         delegate: delegate,
                                         dto: dto)
        children.append(coordinator)
        let vc = coordinator.start()
        coordinator.onDidFinish = { [weak self] coordinator in
            self?.children.removeAll { coordinator == $0 }
            vc.dismiss(animated: true)
        }
        
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .flipHorizontal
        rootVC?.present(vc, animated: true)
    }
}
