//
//  LoginVM.swift
//  NoteMe
//
//  Created by PavelKrm on 10.11.23.
//

import UIKit

@objc protocol LoginKeyboardHelperUseCase {
    
    typealias KeyboardFrameHandler = (CGRect) -> Void
    
    func onWillShow(_ handler: @escaping KeyboardFrameHandler) -> Self
    func onWillHide(_ handler: @escaping KeyboardFrameHandler) -> Self
    @objc optional func onDidShow(_ handler: @escaping KeyboardFrameHandler) -> Self
    @objc optional func onDidhide(_ handler: @escaping KeyboardFrameHandler) -> Self
}

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
    private let keyboardHelper: LoginKeyboardHelperUseCase
    
    init(authService: LoginAuthServiceUseCase,
         inputValidator: LoginInputValidatorUseCase,
         keyboardHelper: KeyboardHelper) {
        self.authService = authService
        self.inputValidator = inputValidator
        self.keyboardHelper = keyboardHelper
    }
    
    func loginDidTap(email: String?, pass: String?) {
        
        guard
            checkValidation(email: email, pass: pass),
            let email, let pass
        else { return }
        authService.login(email: email, pass: pass, completion: { print($0) })
    }
    
    func newAccountDidTap() {
        print(#function)
    }
    
    func forgotPassDidTap(email: String?) {}
    
    private func checkValidation(email: String?, pass: String?) -> Bool {
        
        let isEmailValid = inputValidator.validate(email: email)
        let isPasswordValid = inputValidator.validate(pass: pass)
        
        catchEmailError?(isEmailValid ? nil : "Wrong e-mail")
        catchPassError?(isPasswordValid ? nil : "Non-valid password")
        
        return isEmailValid && isPasswordValid
    }
    
    func keyboardFrameChanged(completion: @escaping (CGRect) -> Void) {
        keyboardHelper.onWillShow {
            completion($0)
        }.onWillHide { 
            completion($0)
        }
    }
}
