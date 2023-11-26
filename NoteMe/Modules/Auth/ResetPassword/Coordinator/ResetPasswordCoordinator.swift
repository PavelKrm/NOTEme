//
//  ResetPasswordCoordinator.swift
//  NoteMe
//
//  Created by PavelKrm on 26.11.23.
//

import UIKit

final class ResetPasswordCoordinator: Coordinator {
    
    override func start() -> UIViewController {
        return ResetPasswordAssembler.make(coordinator: self)
    }
    
    override func finish() {
        onDidFinish?(self)
    }
}

extension ResetPasswordCoordinator: ResetPasswordCoordinatorProtocol {}
