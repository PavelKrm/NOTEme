//
//  MenuAssembler.swift
//  NoteMe
//
//  Created by PavelKrm on 12.02.24.
//

import UIKit

final class MenuAssembler {
    
    private init() {}
    
    static func make(
        menu: MenuRows,
        coordinator: MenuCoordinatorProtocol
    ) -> UIViewController {
        let vm = MenuVM(adapter: MenuAdapter(),
                        coordinator: coordinator,
                        menu: menu)
        
        let vc = MenuVC(viewModel: vm)
        vc.popoverPresentationController?.backgroundColor = .white
        vc.modalPresentationStyle = .popover
        switch menu {
        case .addNotificationMenu(_):
            vc.popoverPresentationController?.permittedArrowDirections = .down
        case .actionsMenu(_):
            vc.popoverPresentationController?.permittedArrowDirections = .up
        }
        
        return vc
    }
}
