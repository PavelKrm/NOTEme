//
//  RegisterPresenter.swift
//  NoteMe
//
//  Created by PavelKrm on 14.11.23.
//

import UIKit
import FirebaseAuth

protocol RegisterCoordinatorProtocol: AnyObject {
    
    func finish()
    func showAlert(_ alert: UIAlertController)
}

protocol RegisterAuthServiceUseCase {
    
    func signUp(email: String,
                pass: String,
                completion: @escaping(Result<User, Error>) -> Void)
}

protocol RegisterInputValidatorUseCase {
    
    func validate(email: String?) -> Bool
    func validate(pass:String?) -> Bool
}

protocol RegisterAlertServiceUseCaseProtocol {
    
    func showAlert(title: String?, message: String?, okTitle: String?)
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
    
    private let authService: RegisterAuthServiceUseCase
    private let keyboardHelper: RegisterKeyboardHelperUseCase
    private let inputValidator: RegisterInputValidatorUseCase
    private let alertService: RegisterAlertServiceUseCaseProtocol
    
    init(coordinator: RegisterCoordinatorProtocol,
         keyboardHelper: RegisterKeyboardHelperUseCase,
         authService: RegisterAuthServiceUseCase,
         inputValidator: RegisterInputValidatorUseCase,
         alertService: RegisterAlertServiceUseCaseProtocol) {
        self.keyboardHelper = keyboardHelper
        self.authService = authService
        self.inputValidator = inputValidator
        self.coordinator = coordinator
        self.alertService = alertService
        
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
        authService.signUp(email: email, pass: pass) { [weak self]
            result in
            switch result {
            case .success(let user):
                print(user.uid)
                self?.coordinator?.finish()
                
            case .failure(let error):
                self?.alertService.showAlert(title: L10n.errorAlertTitle,
                                             message: error.localizedDescription,
                                             okTitle: L10n.okBtnAlertTitle)
            }
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
        
        self.delegate?.setEmailError(
            error: isEmailValid ? nil : "Wrong e-mail")
        self.delegate?.setPasswordError(
            error: isPasswordValid ? nil : "Non-valid password")
        self.delegate?.setRepeatPasswordError(
            error: isRepeatPassValid ? nil : "Non-valid repeat")
        
        return isEmailValid && isPasswordValid && isRepeatPassValid
    }
}

// MARK: - L10n

extension RegisterPresenter {
    
    private enum L10n {
        
        static var errorAlertTitle = "RegisterPresenter_ErrorAlert_title".localized
        static var okBtnAlertTitle = "RegisterPresenter_okButtonAlert_tatile".localized
    }
}
