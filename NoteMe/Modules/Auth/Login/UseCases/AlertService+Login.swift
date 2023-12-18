//
//  AlertService+Login.swift
//  NoteMe
//
//  Created by PavelKrm on 18.12.23.
//

import Foundation

extension AlertService: LoginAlertServiceUseCase {
    
    func showAlert(title: String, message: String, okTitle: String) {
        showAlert(title: title, message: message, okTitle: okTitle, okHandler: nil)
    }
}
