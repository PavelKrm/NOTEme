//
//  ResetPasswordCoordinator.swift
//  NoteMe
//
//  Created by PavelKrm on 26.11.23.
//

import UIKit

final class ResetPasswordCoordinator: Coordinator {
    
    private var rootVC: UIViewController?
    private let container: Container
    
    init(container: Container) {
        self.container = container
    }
    
    override func start() -> UIViewController {
        let vc = ResetPasswordAssembler.make(container: container,
                                             coordinator: self)
        rootVC = vc
        return vc
    }
    
    override func finish() {
        onDidFinish?(self)
    }
}

extension ResetPasswordCoordinator: ResetPasswordCoordinatorProtocol {}
