//
//  HomeAssembler.swift
//  NoteMe
//
//  Created by PavelKrm on 29.11.23.
//

import UIKit

final class HomeAssembler {
    
    private init() {}
    
//    static func make(coordinator: HomeCoordinator) -> UIViewController {
//        
//        let vm = HomeVM(coordinator: coordinator)
//        return HomeVC(viewModel: vm)
//    }
    
    static func make() -> UIViewController {
        
        let vm = HomeVM()
        return HomeVC(viewModel: vm)
    }
}


