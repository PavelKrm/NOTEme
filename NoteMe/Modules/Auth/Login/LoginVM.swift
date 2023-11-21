//
//  LoginVM.swift
//  NoteMe
//
//  Created by PavelKrm on 10.11.23.
//

import UIKit

protocol LoginCoordinatorProtocol: AnyObject {
    
    func finish()
    func openRegisterModule()
    func openResetPasswordModule()
}

@objc protocol LoginKeyboardHelperUseCase {
    
    typealias KeyboardFrameHandler = (CGRect) -> Void
    
    @discardableResult
    func onWillShow(_ handler: @escaping KeyboardFrameHandler) -> Self
    @discardableResult
    func onWillHide(_ handler: @escaping KeyboardFrameHandler) -> Self
    @discardableResult
    @objc optional func onDidShow(_ handler: @escaping KeyboardFrameHandler) -> Self
    @discardableResult
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
    
    private weak var coordinator: LoginCoordinatorProtocol?
    
    private let authService: LoginAuthServiceUseCase
    private let inputValidator: LoginInputValidatorUseCase
    private let keyboardHelper: LoginKeyboardHelperUseCase
    
    init(coordinator: LoginCoordinatorProtocol,
         authService: LoginAuthServiceUseCase,
         inputValidator: LoginInputValidatorUseCase,
         keyboardHelper: KeyboardHelper) {
        self.authService = authService
        self.inputValidator = inputValidator
        self.keyboardHelper = keyboardHelper
        self.coordinator = coordinator
    }
    
    func loginDidTap(email: String?, pass: String?) {
        
        guard
            checkValidation(email: email, pass: pass),
            let email, let pass
        else { return }
        authService.login(email: email, pass: pass) { [weak coordinator]
            isSuccess in
            print(isSuccess)
            coordinator?.finish()
        }
    }
    
    func newAccountDidTap() {
        print(#function)
        coordinator?.openRegisterModule()
    }
    
    func forgotPassDidTap(email: String?) {
        print(#function)
        coordinator?.openResetPasswordModule()
    }
    
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
