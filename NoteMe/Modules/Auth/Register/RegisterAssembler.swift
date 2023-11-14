//
//  RegisterAssembler.swift
//  NoteMe
//
//  Created by PavelKrm on 14.11.23.
//

import UIKit

final class RegisterAssembler {
    
    private init() {}
    
    static func make() -> UIViewController {
        
        let presentor = RegisterPresentor(keyboardHelper: .init())
        let vc = RegisterVC(presenter: presentor)
        
        presentor.delegate = vc
        
        return vc
    }
}
