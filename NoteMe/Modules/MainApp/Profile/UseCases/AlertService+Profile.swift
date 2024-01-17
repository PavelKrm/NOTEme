//
//  AlertService+Profile.swift
//  NoteMe
//
//  Created by PavelKrm on 15.01.24.
//

import Foundation

struct ProfileAlertServiceUseCase: ProfileAlertServiceUseCaseProtocol {
    
    private let alertService: AlertService
    
    init(alertService: AlertService) {
        self.alertService = alertService
    }
    
    func show(title: String?,
              message: String?,
              okTitle: String?,
              cancelTitle: String?,
              okHandler: (() -> Void)?) {
        
        alertService.showAlertDestructiveOk(title: title,
                                            message: message,
                                            cancelTitle: cancelTitle, 
                                            okTitle: okTitle,
                                            okHandler: okHandler)
    }
}
