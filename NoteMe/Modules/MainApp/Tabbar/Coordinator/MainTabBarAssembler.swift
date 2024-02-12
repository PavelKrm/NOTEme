//
//  TabBarAssembler.swift
//  NoteMe
//
//  Created by PavelKrm on 30.11.23.
//

import UIKit

final class MainTabBarAssembler {
    
    private init() {}
    
    static func make(with views: [UIViewController],
                     coordinator: MainTabBarCoordinatorProtocol) -> UITabBarController {
        let vm = MainTabBarVM(coordinator: coordinator)
        let tabBar = MainTabBarVC(viewModel: vm)
        tabBar.viewControllers = views
        
        return tabBar
    }
}
