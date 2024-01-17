//
//  AlertService+ResetPassword.swift
//  NoteMe
//
//  Created by PavelKrm on 17.01.24.
//

import Foundation

struct ResetPasswordAlertServiceUseCase: ResetPasswordAlertServiceUseCaseProtocol {

    private let alertService: AlertService
    
    init(alertService: AlertService) {
        self.alertService = alertService
    }
    
    func showAlert(title: String, 
                   message: String,
                   okTitle: String,
                   okHandler: (() -> Void)?) {
        
        alertService.showAlert(title: title,
                               message: message,
                               okTitle: okTitle,
                               okHandler: okHandler)
    }
}
