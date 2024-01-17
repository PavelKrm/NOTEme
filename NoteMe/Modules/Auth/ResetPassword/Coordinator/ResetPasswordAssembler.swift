//
//  ResetPasswordAssembler.swift
//  NoteMe
//
//  Created by PavelKrm on 19.11.23.
//

import UIKit

final class ResetPasswordAssembler {
    
    private init() {}
    
    static func make(container: Container,
                     coordinator: ResetPasswordCoordinatorProtocol) -> UIViewController {
        
        let inputValidator: InputValidator = container.resolve()
        let authService: AuthService = container.resolve()
        let alertServiceUseCase = ResetPasswordAlertServiceUseCase(alertService: container.resolve())
        
        let vm = ResetPasswordVM(coordinator: coordinator,
                                 inputValidator: inputValidator,
                                 authService: authService,
                                 alertService: alertServiceUseCase)
        
        return ResetPasswordVC(viewModel: vm)
    }
}
