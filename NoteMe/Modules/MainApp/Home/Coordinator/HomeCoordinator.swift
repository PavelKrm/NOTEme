//
//  HomeCoordinator.swift
//  NoteMe
//
//  Created by PavelKrm on 29.11.23.
//

import UIKit

final class HomeCoordinator: Coordinator {
    
    private var rootNC: UINavigationController?
    
    override func start() -> UIViewController {
        return HomeAssembler.make()
    }
}

extension HomeCoordinator: HomeViewModelCoordinatorProtocol {}
