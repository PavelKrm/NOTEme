//
//  LoginAssembler.swift
//  NoteMe
//
//  Created by PavelKrm on 10.11.23.
//

import UIKit

final class LoginAssembler {
    
    private init() {}
    
    static func make(coodinator: LoginCoordinatorProtocol) -> UIViewController {
        
        let vm = LoginVM(coordinator: coodinator,
                         authService: AuthService(),
                         inputValidator: InputValidator(),
                         keyboardHelper: KeyboardHelper())
        return LoginVC(viewModel: vm,
                       animateConstsChange: AnimateConstraintsChange())
    }
}

//MARK: - Test acc
// test@test.com
// 123NoteMe*
