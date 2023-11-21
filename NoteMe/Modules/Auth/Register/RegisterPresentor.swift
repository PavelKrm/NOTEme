//
//  RegisterPresenter.swift
//  NoteMe
//
//  Created by PavelKrm on 14.11.23.
//

import UIKit

protocol RegisterCoordinatorProtocol: AnyObject {
    
    func finish()
}

protocol SignupAuthServiceUseCase {
    
    func signup(email: String,
                pass: String,
                completion: @escaping(Bool) -> Void)
}

protocol RegisterInputValidatorUseCase {
    
    func validate(email: String?) -> Bool
    func validate(pass:String?) -> Bool
}

@objc protocol RegisterKeyboardHelperUseCase {
    
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

protocol RegisterPresenterDelegate: AnyObject {
    
    func setEmailError(error: String?)
    func setPasswordError(error: String?)
    func setRepeatPasswordError(error: String?)
    
    func keyboardFrameChanged(_ frame: CGRect)
}

final class RegisterPresenter: RegisterPresenterProtocol {
    
    weak var delegate: RegisterPresenterDelegate?
    
    private weak var coordinator: RegisterCoordinatorProtocol?
    
    private let authService: SignupAuthServiceUseCase
    private let keyboardHelper: RegisterKeyboardHelperUseCase
    private let inputValidator: RegisterInputValidatorUseCase
    
    init(coordinator: RegisterCoordinatorProtocol,
         keyboardHelper: RegisterKeyboardHelperUseCase,
         authService: SignupAuthServiceUseCase,
         inputValidator: RegisterInputValidatorUseCase) {
        self.keyboardHelper = keyboardHelper
        self.authService = authService
        self.inputValidator = inputValidator
        self.coordinator = coordinator
        
        bind()
    }
    
    private func bind() {
        
        keyboardHelper.onWillShow { [weak self] in
            self?.delegate?.keyboardFrameChanged($0)
        }.onWillHide { [weak self] in
            self?.delegate?.keyboardFrameChanged($0)
        }
    }
    
    func registerDidTap(email: String?, pass: String?, repeat: String?) {
        
        guard
            checkValidation(email: email, pass: pass, repeat: `repeat`),
            let email, let pass else { return }
        
        authService.signup(email: email, pass: pass) { [weak coordinator]
            isSuccess in
            print(isSuccess)
            coordinator?.finish()
        }
    }
    
    func haveAnAccountDidTap() {
        coordinator?.finish()
    }
    
    private func checkValidation(email: String?,
                                 pass: String?,
                                 repeat: String?) -> Bool {
        
        let isEmailValid = inputValidator.validate(email: email)
        let isPasswordValid = inputValidator.validate(pass: pass)
        let isRepeatPassValid = (pass == `repeat` ? true : false)
        
        self.delegate?.setEmailError(error: isEmailValid ? nil : "Wrong e-mail")
        self.delegate?.setPasswordError(error: isPasswordValid ? nil : "Non-valid password")
        self.delegate?.setRepeatPasswordError(error: isRepeatPassValid ? nil : "Non-valid repeat")
        
        return isEmailValid && isPasswordValid && isRepeatPassValid
    }
}
