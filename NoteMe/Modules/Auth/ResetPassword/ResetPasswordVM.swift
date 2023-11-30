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
    
    var showAlert: ((Bool) -> Void)?
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
        authService.resetPassword(email: email) {
            print($0)
            self.showAlert?($0)
        }
    }
    
    private func checkValidation(email: String?) -> Bool {
        
        let isEmailValid = inputValidator.validate(email: email)
        catchEmailError?(isEmailValid ? nil : "Wrong e-mail")
        
        return isEmailValid
    }
}
