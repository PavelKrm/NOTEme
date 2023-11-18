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
                repeat: String,
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
    
    init(keyboardHelper: KeyboardHelper,
         authService: SignupAuthServiceUseCase) {
        self.keyboardHelper = keyboardHelper
        self.authService = authService
        
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
        
        guard let email,
              let pass,
              let `repeat` else { return }
        
        authService.signup(email: email,
                           pass: pass,
                           repeat: `repeat`,
                           completion: { print("sigup \($0)")})
    }
    
    func haveAnAccountDidTap() {
    }
}
