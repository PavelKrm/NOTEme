//
//  AlertService+Profile.swift
//  NoteMe
//
//  Created by PavelKrm on 15.01.24.
//

import Foundation

extension AlertService: ProfileAlertServiceUseCase {
    func show(title: String,
                     message: String,
                     okTitle: String,
                     cancelTitle: String,
                     okHandler: (() -> Void)?) {
        showAlert(title: title,
                  message: message,
                  cancelTitle: cancelTitle,
                  okTitle: okTitle,
                  okHandler: okHandler)
    }
}
