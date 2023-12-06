//
//  ResetPasswordVM.swift
//  NoteMe
//
//  Created by PavelKrm on 19.11.23.
//

import UIKit

protocol ResetPasswordCoordinatorProtocol: AnyObject {
    
    func finish()
    func showAlert(_ alert: UIAlertController)
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
                let alert = AlertBuilder.build(
                    title: "ResetPassVC_OkAlert_title".localized,
                    message: "ResetPassVC_OkAlert_message".localized,
                    okTitle: "ResetPasswordVC_OkButtonAlert_title".localized) {
                        coordinator?.finish()
                    }
                coordinator?.showAlert(alert)
            } else {
                let alert = AlertBuilder.build(
                    title: "ResetPassVC_ErrAlert_title".localized,
                    message: "ResetPassVC_ErrAlert_message".localized,
                    okTitle: "ResetPasswordVC_OkButtonAlert_title".localized)
                coordinator?.showAlert(alert)
            }
        }
    }
    
    private func checkValidation(email: String?) -> Bool {
        
        let isEmailValid = inputValidator.validate(email: email)
        catchEmailError?(isEmailValid ? nil : "Wrong e-mail")
        
        return isEmailValid
    }
}
