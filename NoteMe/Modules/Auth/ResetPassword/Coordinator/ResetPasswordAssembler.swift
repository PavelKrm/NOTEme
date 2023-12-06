//
//  ResetPasswordAssembler.swift
//  NoteMe
//
//  Created by PavelKrm on 19.11.23.
//

import UIKit

final class ResetPasswordAssembler {
    
    private init() {}
    
    static func make(coordinator: ResetPasswordCoordinatorProtocol) -> UIViewController {
        
        let vm = ResetPasswordVM(coordinator: coordinator,
                                 inputValidator: InputValidator(),
                                 authService: AuthService())
        
        return ResetPasswordVC(viewModel: vm)
    }
}
