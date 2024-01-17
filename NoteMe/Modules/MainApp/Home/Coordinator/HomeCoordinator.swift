//
//  HomeCoordinator.swift
//  NoteMe
//
//  Created by PavelKrm on 29.11.23.
//

import UIKit

final class HomeCoordinator: Coordinator {
    
    private let container: Container
    
    init(container: Container) {
        self.container = container
    }
    
    override func start() -> UIViewController {
        return HomeAssembler.make()
    }
}

extension HomeCoordinator: HomeViewModelCoordinatorProtocol {}
