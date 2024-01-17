//
//  ProfileAssembler.swift
//  NoteMe
//
//  Created by PavelKrm on 30.11.23.
//

import UIKit

final class ProfileAssembler {
    
    private init() {}
    
    static func make(container: Container) -> UIViewController {
        
        let authService: AuthService = container.resolve()
        let alertServiceUseCase = ProfileAlertServiceUseCase(alertService: container.resolve())
        
        let vm = ProfileVM(authService: authService,
                           alertService: alertServiceUseCase)
        
        return ProfileVC(viewModel: vm)
    }
}
