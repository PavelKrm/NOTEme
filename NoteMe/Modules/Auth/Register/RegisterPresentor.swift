//
//  RegisterPresentor.swift
//  NoteMe
//
//  Created by PavelKrm on 14.11.23.
//

import UIKit

protocol RegisterPresentorDelegate: AnyObject {
    
    func setEmailError(error: String?)
    func setPasswordError(error: String?)
    func setRepeatPasswordError(error: String?)
    
    func keyboardFrameChanged(_ frame: CGRect)
}

final class RegisterPresentor: RegisterPresentorProtocol {
    
    weak var delegate: RegisterPresentorDelegate?
    
    private let keyboardHelper: KeyboardHelper
    
    init(keyboardHelper: KeyboardHelper) {
        self.keyboardHelper = keyboardHelper
        
        bind()
    }
    
    private func bind() {
        
        keyboardHelper.onWillShow { [weak self] in
            self?.delegate?.keyboardFrameChanged($0)
        }.onWillHide { [weak self] in
            self?.delegate?.keyboardFrameChanged($0)
        }
        
    }
    
    func registerDidTap(email: String?, pass: String?, repeat: String?) {
    }
    
    func haveAnAccountDidTap() {
    }
}
