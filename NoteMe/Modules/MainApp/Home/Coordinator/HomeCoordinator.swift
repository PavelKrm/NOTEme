//
//  HomeCoordinator.swift
//  NoteMe
//
//  Created by PavelKrm on 29.11.23.
//

import UIKit

final class HomeCoordinator: Coordinator {
    
    private var rootNC: UINavigationController?
    
//    override func start() -> UIViewController {
//        
//        let vc = HomeAssembler.make(coordinator: self)
//        let nc = UINavigationController(rootViewController: vc)
//        self.rootNC = nc
//        return nc
//    }
}

extension HomeCoordinator: HomeViewModelCoordinatorProtocol {}
