//
//  ResetPasswordCoordinator.swift
//  NoteMe
//
//  Created by PavelKrm on 26.11.23.
//

import UIKit

final class ResetPasswordCoordinator: Coordinator {
    
    private var rootVC: UIViewController?
    
    override func start() -> UIViewController {
        let vc = ResetPasswordAssembler.make(coordinator: self)
        rootVC = vc
        return vc
    }
    
    override func finish() {
        onDidFinish?(self)
    }
}

extension ResetPasswordCoordinator: ResetPasswordCoordinatorProtocol {}
