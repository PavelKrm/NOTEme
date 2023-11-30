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
        
        let vm = ProfileVM()
        return ProfileVC(viewModel: vm)
    }
}
