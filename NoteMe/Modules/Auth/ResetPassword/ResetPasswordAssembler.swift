//
//  ResetPasswordAssembler.swift
//  NoteMe
//
//  Created by PavelKrm on 19.11.23.
//

import UIKit

final class ResetPasswordAssembler {
    
    private init() {}
    
    static func make() -> UIViewController {
        
        let vm = ResetPasswordVM(inputValidator: InputValidator(),
                                 authService: TESTResetAuthService())
        
        return ResetPasswordVC(viewModel: vm)
    }
}

private class TESTResetAuthService: ResetPasswordAuthServiceUseCase {
    func resetPassword(email: String, completion: @escaping(Bool) -> Void) {
        completion(true)
    }
}
