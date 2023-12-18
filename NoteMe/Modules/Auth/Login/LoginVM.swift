//
//  LoginVM.swift
//  NoteMe
//
//  Created by PavelKrm on 10.11.23.
//

import UIKit
import FirebaseAuth

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

protocol LoginAlertServiceUseCase {
    
    func showAlert(title: String, message: String, okTitle: String)
}

protocol LoginInputValidatorUseCase {
    
    func validate(email: String?) -> Bool
}

protocol LoginAuthServiceUseCase {
    
    func signIn(email: String,
                pass: String,
                completion: @escaping(Result<User, Error>) -> Void)
}

final class LoginVM: LoginViewModelProtocol {
    
    var catchEmailError: ((String?) -> Void)?
    var keyboardFrameChanged: ((CGRect) -> Void)?
    
    private weak var coordinator: LoginCoordinatorProtocol?
    
    private let authService: LoginAuthServiceUseCase
    private let inputValidator: LoginInputValidatorUseCase
    private let keyboardHelper: LoginKeyboardHelperUseCase
    private let alertService: LoginAlertServiceUseCase
    
    init(coordinator: LoginCoordinatorProtocol,
         authService: LoginAuthServiceUseCase,
         inputValidator: LoginInputValidatorUseCase,
         keyboardHelper: KeyboardHelper,
         alertService: LoginAlertServiceUseCase) {
        
        self.authService = authService
        self.inputValidator = inputValidator
        self.keyboardHelper = keyboardHelper
        self.coordinator = coordinator
        self.alertService = alertService
        
        bind()
    }
    
    func loginDidTap(email: String?, pass: String?) {
        
        guard
            checkValidation(email: email, pass: pass),
            let email, let pass
        else { return }
        
        authService.signIn(email: email, pass: pass) { [weak self]
            result in
            switch result {
            case .success(let user):
                print(user.uid)
                //FIXME: - uncomment
                ParametersHelper.set(.authenticated, value: true)
                self?.coordinator?.finish()
                
            case .failure(let error):
                
                self?.alertService.showAlert(title: "Error",
                                               message: error.localizedDescription,
                                               okTitle: "ok")
            }
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
        catchEmailError?(isEmailValid ? nil : "Wrong e-mail")
        
        return isEmailValid
    }
    
    func bind() {
        keyboardHelper.onWillShow { [weak self] in
            self?.keyboardFrameChanged?($0)
        }.onWillHide { [weak self] in
            self?.keyboardFrameChanged?($0)
        }
    }
}
