//
//  LoginAssembler.swift
//  NoteMe
//
//  Created by PavelKrm on 10.11.23.
//

import UIKit

final class LoginAssembler {
    
    private init() {}
    
    static func make(container: Container,
                     coodinator: LoginCoordinatorProtocol) -> UIViewController {
        
        let authService: AuthService = container.resolve()
        let inputValidator: InputValidator = container.resolve()
        let alertService: AlertService = container.resolve()
        let keyboardHelper: KeyboardHelper = container.resolve()
        
        let vm = LoginVM(coordinator: coodinator,
                         authService: authService,
                         inputValidator: inputValidator,
                         keyboardHelper: keyboardHelper,
                         alertService: alertService)
        return LoginVC(viewModel: vm,
                       animateConstsChange: AnimateConstraintsChange())
    }
}

//MARK: - Test acc
// test@test.com
// 123NoteMe*
