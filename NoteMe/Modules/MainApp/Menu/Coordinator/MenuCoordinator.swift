//
//  MenuCoordinator.swift
//  NoteMe
//
//  Created by PavelKrm on 12.02.24.
//

import UIKit

final class MenuCoordinator: Coordinator {
    
    var onDismissedByUser: ((Coordinator) -> Void)?
    private var menu: MenuRows
    
    init(menu: MenuRows) {
        self.menu = menu
    }
    
    override func start() -> UIViewController {
        return MenuAssembler.make(menu: menu,
                                  coordinator: self)
    }
}

extension MenuCoordinator: MenuCoordinatorProtocol {
    
    func addNotification(for type: AddNotification) {
        
    }
    
    func editRowDidTap() {}
    
    func deleteRowDidTap() {}
    
    func dismissedByUser() {
        onDismissedByUser?(self)
    }
}
