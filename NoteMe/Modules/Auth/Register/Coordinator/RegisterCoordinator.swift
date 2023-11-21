//
//  RegisterCoordinator.swift
//  NoteMe
//
//  Created by PavelKrm on 21.11.23.
//

import UIKit

final class RegisterCoordinator: Coordinator {
    
    override func start() -> UIViewController {
        return RegisterAssembler.make(coordinator: self)
    }
    
    override func finish() {
        onDidFinish?(self)
    }
}

extension RegisterCoordinator: RegisterCoordinatorProtocol {}
