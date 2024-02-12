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
        return MenuVC(viewModel: vm)
    }
}
