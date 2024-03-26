//
//  MenuCoordinator.swift
//  NoteMe
//
//  Created by PavelKrm on 12.02.24.
//

import UIKit

final class MenuCoordinator: Coordinator {
    
    private var rootVC: UIViewController?
    var onDismissedByUser: ((Coordinator) -> Void)?
    var onAddedNotificationByUser: ((MenuRows) -> Void)?
    private let container: Container
    private var menu: MenuRows
    
    init(menu: MenuRows, container: Container) {
        self.menu = menu
        self.container = container
    }
    
    override func start() -> UIViewController {
        let vc =  MenuAssembler.make(menu: menu,
                                  coordinator: self)
        rootVC = vc
        return vc
    }
}

extension MenuCoordinator: MenuCoordinatorProtocol {
    
    func addNotification(for type: AddNotification) {
        onDismissedByUser?(self)
        onAddedNotificationByUser?(.addNotificationMenu([type]))
    }
    
    func editRowDidTap() {}
    
    func deleteRowDidTap() {}
    
    func dismissedByUser() {
        onDismissedByUser?(self)
    }
}
