//
//  AuthService+Profile.swift
//  NoteMe
//
//  Created by PavelKrm on 14.01.24.
//

import Foundation

struct ProfileAuthServiceUseCase: ProfileAuthServiceUseCaseProtocol {
    
    private let authService: AuthService
    
    init(authService: AuthService) {
        self.authService = authService
    }
    
    func logout() -> Bool {
        return authService.logout()
    }
    
    func getUserEmail() -> String? {
        return authService.currentUserEmail()
    }
}
