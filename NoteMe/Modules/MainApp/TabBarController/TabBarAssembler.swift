//
//  TabBarAssembler.swift
//  NoteMe
//
//  Created by PavelKrm on 30.11.23.
//

import UIKit

final class TabBarAssembler {
    
    private init() {}
    
    static func make() -> UIViewController {
        
        let vm = TabBarVM()
        return TabBarController(viewModel: vm)
    }
}
