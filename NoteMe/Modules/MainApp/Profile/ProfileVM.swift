//
//  ProfileVM.swift
//  NoteMe
//
//  Created by PavelKrm on 30.11.23.
//

import UIKit
protocol ProfileCoordinatorProtocol {}

protocol ProfileAuthServiceUseCase {
    
    func logout() -> Bool
    func checkUserEmail(completion: @escaping(String?) -> Void)
}

final class ProfileVM: ProfileViewModelProtocol {
    
    var catchEmail: ((String?) -> Void)?
    var catchExportInfo: ((String?) -> Void)?
    
    private let authService: ProfileAuthServiceUseCase
    
    init(authService: ProfileAuthServiceUseCase) {
        
        self.authService = authService
    }
    
    func getEmail() {
        authService.checkUserEmail { [weak self] email in
            self?.catchEmail?(email)
        }

    }

    func notificationDidTap() {}
    
    func exportDidTap() {}
    
    func logoutDidTap() {
        
        //if logout true -> loginVC
        //else alert
//        authService.logout()
    }
}
