//
//  HomeAssembler.swift
//  NoteMe
//
//  Created by PavelKrm on 29.11.23.
//

import UIKit

final class HomeAssembler {
    
    private init() {}
    
    static func make() -> UIViewController {
        
        let vm = HomeVM()
        return HomeVC(viewModel: vm)
    }
}


