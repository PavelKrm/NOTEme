//
//  MainTabBarCoordinator.swift
//  NoteMe
//
//  Created by PavelKrm on 18.12.23.
//

import UIKit

final class MainTabBarCoordinator: Coordinator {
    
    private var rootVC: UIViewController?
    private let container: Container
    
    init(container: Container) {
        self.container = container
    }
    
    override func start() -> UIViewController {
        
        let views = [makeHomeModule(), makeProfileModule()]
        
        let tabBar = MainTabBarAssembler.make(with: views,
                                              coordinator: self)
        rootVC = tabBar
        return tabBar
    }
    
    private func makeHomeModule() -> UIViewController {
        
        let coordinator = HomeCoordinator(container: container)
        children.append(coordinator)
        
        return coordinator.start()
    }
    
    private func makeProfileModule() -> UIViewController {
        
        let coordinator = ProfileCoordinator(container: container)
        children.append(coordinator)
        
        return coordinator.start()
    }
    
    func openMenu(with view: UIView) {
        let coordinator = MenuCoordinator(menu: .addNotificationMenu(AddNotification.allCases))
        children.append(coordinator)
        let vc = coordinator.start()
        coordinator.onDidFinish = { [weak self] coordinator in
            self?.children.removeAll { coordinator == $0 }
        }
        
        coordinator.onDismissedByUser = { [weak self] coordinator in
            self?.children.removeAll() { coordinator == $0 }
        }
        
        vc.modalPresentationStyle = .popover
        vc.popoverPresentationController?.permittedArrowDirections = .down
        vc.popoverPresentationController?.sourceRect = CGRect(
                                                            x: view.bounds.midX,
                                                            y: view.bounds.midY,
                                                            width: .zero,
                                                            height: .zero
                                                            )
        vc.popoverPresentationController?.sourceView = view
        vc.popoverPresentationController?.delegate = vc
        vc.popoverPresentationController?.backgroundColor = .white
        rootVC?.present(vc, animated: true)
    }
}

extension MainTabBarCoordinator: MainTabBarCoordinatorProtocol {}

extension UIViewController: UIPopoverPresentationControllerDelegate {
    
    public func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}
