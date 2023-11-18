//
//  ResetPasswordVM.swift
//  NoteMe
//
//  Created by PavelKrm on 19.11.23.
//

import UIKit

protocol ResetPasswordInputValidatorUseCase {
    
    func validate(email: String?) -> Bool
}

protocol ResetPasswordAuthServiceUseCase {
    
    func resetPassword(email: String, completion: @escaping(Bool) -> Void)
}

final class ResetPasswordVM: ResetPasswordViewModelProtocol {
    
    
    var catchEmailError: ((String?) -> Void)?
    
    private var inputValidator: ResetPasswordInputValidatorUseCase
    private var authService: ResetPasswordAuthServiceUseCase
    
    init(inputValidator: ResetPasswordInputValidatorUseCase,
         authService: ResetPasswordAuthServiceUseCase) {
        self.inputValidator = inputValidator
        self.authService = authService
    }
    
    func cancelDidTap() {
        print(#function)
    }
    
    func resetPassDidTap(email: String?) {
        
        guard
            checkValidation(email: email),
            let email else { return }
        authService.resetPassword(email: email, completion: { print($0) })
    }
    
    private func checkValidation(email: String?) -> Bool {
        
        let isEmailValid = inputValidator.validate(email: email)
        catchEmailError?(isEmailValid ? nil : "Wrong e-mail")
        
        return isEmailValid
    }
}
