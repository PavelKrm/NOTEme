//
//  TabBarAssembler.swift
//  NoteMe
//
//  Created by PavelKrm on 30.11.23.
//

import UIKit

final class MainTabBarAssembler {
    
    private init() {}
    
    static func make() -> UITabBarController {
        
        let tabBar = MainTabBarVC()
        
        return tabBar
    }
}
