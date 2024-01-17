//
//  RegisterAssembler.swift
//  NoteMe
//
//  Created by PavelKrm on 14.11.23.
//

import UIKit

final class RegisterAssembler {
    
    private init() {}
    
    static func make(container: Container,
                     coordinator: RegisterCoordinatorProtocol) -> UIViewController {
        
        let keyboardHelper: KeyboardHelper = container.resolve()
        let authService: AuthService = container.resolve()
        let inputValidator: InputValidator = container.resolve()
        let alertServiceUseCase = RegisterAlertServiceUseCase(alertService: container.resolve())
        
        let presenter = RegisterPresenter(coordinator: coordinator,
                                          keyboardHelper: keyboardHelper,
                                          authService: authService,
                                          inputValidator: inputValidator,
                                          alertService: alertServiceUseCase)
        
        let constraintsChange: AnimateConstraintsChange = container.resolve()
        
        let vc = RegisterVC(presenter: presenter,
                            animateConstsChange: constraintsChange)
        
        presenter.delegate = vc
        
        return vc
    }
}
