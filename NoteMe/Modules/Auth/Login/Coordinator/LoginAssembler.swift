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
                         authService: TESTAuthService(),
                         inputValidator: InputValidator(),
                         keyboardHelper: KeyboardHelper())
        return LoginVC(viewModel: vm,
                       animateConstsChange: AnimateConstraintsChange())
    }
}

private class TESTAuthService: LoginAuthServiceUseCase {
    func login(email: String, pass: String, completion: @escaping (Bool) -> Void) {
        completion(true)
    }
}
