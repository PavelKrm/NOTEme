//
//  RegisterAssembler.swift
//  NoteMe
//
//  Created by PavelKrm on 14.11.23.
//

import UIKit

final class RegisterAssembler {
    
    private init() {}
    
    static func make() -> UIViewController {
        
        let presenter = RegisterPresenter(keyboardHelper: .init(),
                                          authService: TESTSignupAuthService())
        let vc = RegisterVC(presenter: presenter)
        
        presenter.delegate = vc
        
        return vc
    }
}

private class TESTSignupAuthService: SignupAuthServiceUseCase {
    func signup(email: String,
                pass: String,
                repeat: String,
                completion: @escaping (Bool) -> Void) {
        completion(true)
    }
}
