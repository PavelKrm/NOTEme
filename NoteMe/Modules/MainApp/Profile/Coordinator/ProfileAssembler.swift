//
//  ProfileAssembler.swift
//  NoteMe
//
//  Created by PavelKrm on 30.11.23.
//

import UIKit

final class ProfileAssembler {
    
    private init() {}
    
    static func make() -> UIViewController {
        
        let vm = ProfileVM(authService: AuthService(),
                           alertService: AlertService.current)
        return ProfileVC(viewModel: vm)
    }
}
