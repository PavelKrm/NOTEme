//
//  ResetPasswordVM.swift
//  NoteMe
//
//  Created by PavelKrm on 19.11.23.
//

import UIKit

protocol ResetPasswordCoordinatorProtocol: AnyObject {
    
    func finish()
}

protocol ResetPasswordInputValidatorUseCase {
    
    func validate(email: String?) -> Bool
}

protocol ResetPasswordAuthServiceUseCase {
    
    func resetPassword(email: String, completion: @escaping(Bool) -> Void)
}

final class ResetPasswordVM: ResetPasswordViewModelProtocol {
    
    var catchEmailError: ((String?) -> Void)?
    
    private weak var coordinator: ResetPasswordCoordinatorProtocol?
    private var inputValidator: ResetPasswordInputValidatorUseCase
    private var authService: ResetPasswordAuthServiceUseCase
    
    init(coordinator: ResetPasswordCoordinatorProtocol,
         inputValidator: ResetPasswordInputValidatorUseCase,
         authService: ResetPasswordAuthServiceUseCase) {
        self.coordinator = coordinator
        self.inputValidator = inputValidator
        self.authService = authService
    }
    
    func finish() {
        coordinator?.finish()
    }
    
    func cancelDidTap() {
        print(#function)
        coordinator?.finish()
    }
    
    func resetPassDidTap(email: String?) {
        
        guard
            checkValidation(email: email),
            let email else { return }
        authService.resetPassword(email: email) { [weak coordinator] isSucces in
            if isSucces {
                AlertService.current.showAlert(title: L10n.okAlertTitle,
                                               message: L10n.okAlertMessage,
                                               okTitle: L10n.okBtnAlertTitle,
                                               okHandler:  {
                    coordinator?.finish()
                })
            } else {
                AlertService.current.showAlert(title: L10n.errorAlertTitle,
                                               message: L10n.errorAlertMessage,
                                               okTitle: L10n.okBtnAlertTitle)
            }
        }
    }
    
    private func checkValidation(email: String?) -> Bool {
        
        let isEmailValid = inputValidator.validate(email: email)
        catchEmailError?(isEmailValid ? nil : "Wrong e-mail")
        
        return isEmailValid
    }
}

//MARK: - L10n

extension ResetPasswordVM {
    
    private enum L10n {
        static var okAlertTitle = "ResetPassVC_OkAlert_title".localized
        static var okAlertMessage = "ResetPassVC_OkAlert_message".localized
        static var okBtnAlertTitle = "ResetPasswordVC_OkButtonAlert_title".localized
        static var errorAlertTitle = "ResetPassVC_ErrAlert_title".localized
        static var errorAlertMessage = "ResetPassVC_ErrAlert_message".localized
    }
}
