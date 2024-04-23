//
//  HomeCoordinator.swift
//  NoteMe
//
//  Created by PavelKrm on 29.11.23.
//

import UIKit
import Storage

final class HomeCoordinator: Coordinator {
    
    var deleteDtoByUser: ((any DTODescription) -> Void)?
    
    private var rootVC: UIViewController?
    private let container: Container
    
    init(container: Container) {
        self.container = container
    }
    
    override func start() -> UIViewController {
        
        let vc = HomeAssembler.make(coordinator: self, container: container)
        rootVC = vc
        return vc
    }
    
    func openActionMenu(for view: UIView, with dto: any DTODescription) {
        
        let coordinator = MenuCoordinator(
            menu: .actionsMenu(ActionsMunuRows.allCases),
            container: container
        )
        
        children.append(coordinator)
        let vc = coordinator.start()
        
        coordinator.actionMenuNotification = { [weak self] action in
            switch action {
            case .edit:
                self?.openEditNotificationModule(for: dto)
            case .delete:
                self?.deleteDtoByUser?(dto)
            }
        }
        
        coordinator.onDidFinish = { [weak self] coordinator in
            self?.children.removeAll { coordinator == $0 }
        }
        
        coordinator.onDismissedByUser = { [weak self] coordinator in
            self?.children.removeAll() { coordinator == $0 }
            vc.dismiss(animated: true)
        }
        
        vc.popoverPresentationController?.sourceView = view
        vc.popoverPresentationController?.delegate = vc
        vc.popoverPresentationController?.sourceRect = CGRect(
                                        x: view.bounds.midX,
                                        y: view.bounds.midY,
                                        width: .zero,
                                        height: .zero
                                                              )

        rootVC?.present(vc, animated: true)
    }
    
    private func openEditNotificationModule(for dto: any DTODescription) {
        
        var coordinator = Coordinator()
        
        switch dto {
        case is DateNotificationDTO:
            coordinator = AddDateNotificationCoordinator(
                                            container: container,
                                            dto: dto as? DateNotificationDTO
                                            )
        case is LocationNotidicationDTO:
            coordinator = AddLocationNotificationCooardinator(
                                            container: container,
                                            dto: dto as? LocationNotidicationDTO
                                            )
        case is TimerNotificationDTO:
            coordinator = AddTimerNotificationCoordinator(
                                            container: container,
                                            dto: dto as? TimerNotificationDTO
                                            )
        default: break
            
        }
        
        children.append(coordinator)
        let vc = coordinator.start()
        coordinator.onDidFinish = { [weak self] coordinator in
            self?.children.removeAll { coordinator == $0}
            vc.dismiss(animated: true)
        }
        
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .coverVertical
        rootVC?.present(vc, animated: true)
    }
}

extension HomeCoordinator: HomeViewModelCoordinatorProtocol {}
