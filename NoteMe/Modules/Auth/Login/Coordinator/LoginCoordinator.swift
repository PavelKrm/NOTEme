//
//  LoginCoordinator.swift
//  NoteMe
//
//  Created by PavelKrm on 21.11.23.
//

import UIKit

final class LoginCoordinator: Coordinator {
    
    private var rootVC: UIViewController?
    private let container: Container
    

    init(container: Container) {
        self.container = container
    }
    override func start() -> UIViewController {
        
        let vc = LoginAssembler.make(container: container,
                                     coodinator: self)
        rootVC = vc
        return vc
    }
    
    override func finish() {
        onDidFinish?(self)
    }
}

extension LoginCoordinator: LoginCoordinatorProtocol {
    
    func openRegisterModule() {
        
        let coordinator = RegisterCoordinator()
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
    
    func openResetPasswordModule() {
        
        let coordinator = ResetPasswordCoordinator()
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

