//
//  RegisterAssembler.swift
//  NoteMe
//
//  Created by PavelKrm on 14.11.23.
//

import UIKit

final class RegisterAssembler {
    
    private init() {}
    
    static func make(coordinator: RegisterCoordinatorProtocol) -> UIViewController {
        
        let presenter = RegisterPresenter(coordinator: coordinator,
                                          keyboardHelper: KeyboardHelper(),
                                          authService: TESTSignupAuthService(),
                                          inputValidator: InputValidator())
        let vc = RegisterVC(presenter: presenter,
                            animateConstsChange: AnimateConstraintsChange())
        
        presenter.delegate = vc
        
        return vc
    }
}

private class TESTSignupAuthService: SignupAuthServiceUseCase {
    func signup(email: String,
                pass: String,
                completion: @escaping (Bool) -> Void) {
        completion(true)
    }
}
