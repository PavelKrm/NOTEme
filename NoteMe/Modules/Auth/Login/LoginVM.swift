//
//  LoginVM.swift
//  NoteMe
//
//  Created by PavelKrm on 10.11.23.
//

import UIKit

protocol LoginInputValidatorUseCase {
    
    func validate(email: String?) -> Bool
    func validate(pass:String?) -> Bool
}

protocol LoginAuthServiceUseCase {
    
    func login(email: String,
               pass: String,
               completion: @escaping(Bool) -> Void)
}

final class LoginVM: LoginViewModelProtocol {
    
    var catchEmailError: ((String?) -> Void)?
    var catchPassError: ((String?) -> Void)?
    
    private let authService: LoginAuthServiceUseCase
    private let inputValidator: LoginInputValidatorUseCase
    
    init(authService: LoginAuthServiceUseCase,
         inputValidator: LoginInputValidatorUseCase) {
        self.authService = authService
        self.inputValidator = inputValidator
    }
    
    func loginDidTap(email: String?, pass: String?) {
        
        guard inputValidator.validate(email: email) else {
            catchEmailError?("Wrong e-mail")
            return
        }
        catchEmailError?(nil)
        
        guard inputValidator.validate(pass: pass) else {
            catchPassError?("Non-valid password")
            return
        }
        catchPassError?(nil)
        
        guard let email, let pass else { return }
        authService.login(email: email, pass: pass, completion: { print($0) })
    }
    
    func newAccountDidTap() {}
    
    func forgotPassDidTap(email: String?) {}
    
}
