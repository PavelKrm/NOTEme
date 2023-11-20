//
//  RegisterPresenter.swift
//  NoteMe
//
//  Created by PavelKrm on 14.11.23.
//

import UIKit

protocol SignupAuthServiceUseCase {
    
    func signup(email: String,
                pass: String,
                completion: @escaping(Bool) -> Void)
}

protocol RegisterPresenterDelegate: AnyObject {
    
    func setEmailError(error: String?)
    func setPasswordError(error: String?)
    func setRepeatPasswordError(error: String?)
    
    func keyboardFrameChanged(_ frame: CGRect)
}

final class RegisterPresenter: RegisterPresenterProtocol {
    
    weak var delegate: RegisterPresenterDelegate?
    private let authService: SignupAuthServiceUseCase
    private let keyboardHelper: KeyboardHelper
    private let inputValidator: InputValidator
    
    init(keyboardHelper: KeyboardHelper,
         authService: SignupAuthServiceUseCase,
         inputValidator: InputValidator) {
        self.keyboardHelper = keyboardHelper
        self.authService = authService
        self.inputValidator = inputValidator
        
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
        
        authService.signup(email: email,
                           pass: pass,
                           completion: { print("sigup \($0)")})
    }
    
    func haveAnAccountDidTap() {
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
