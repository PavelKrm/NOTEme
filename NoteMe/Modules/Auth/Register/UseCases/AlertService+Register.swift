//
//  AlertService+Register.swift
//  NoteMe
//
//  Created by PavelKrm on 18.01.24.
//

import Foundation

struct RegisterAlertServiceUseCase: RegisterAlertServiceUseCaseProtocol {
    
    private let alertService: RegisterAlertServiceUseCaseProtocol
    
    init(alertService: RegisterAlertServiceUseCaseProtocol) {
        self.alertService = alertService
    }
    
    func showAlert(title: String?, message: String?, okTitle: String?) {
        alertService.showAlert(title: title, message: message, okTitle: okTitle)
    }
}
