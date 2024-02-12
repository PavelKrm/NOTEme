//
//  MainTabBarVM.swift
//  NoteMe
//
//  Created by PavelKrm on 12.02.24.
//

import UIKit

protocol MainTabBarCoordinatorProtocol: AnyObject {
    func openMenu(with view: UIView)
}

final class MainTabBarVM: MainTabBarViewModelProtokol {

    private weak var coordinator: MainTabBarCoordinatorProtocol?
    
    init(coordinator: MainTabBarCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func openMenu(with view: UIView) {
        coordinator?.openMenu(with: view)
    }
}
