//
//  TabBarController.swift
//  NoteMe
//
//  Created by PavelKrm on 30.11.23.
//

import UIKit

protocol TabBarViewModelProtocol {}

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    private var viewModel: TabBarViewModelProtocol
    
    init(viewModel: TabBarViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let HomeVC = HomeAssembler.make()
        let tabOneBarItem = UITabBarItem(title: "Home",
                                         image: .General.homeIcon,
                                         selectedImage: .General.selectedHomeIcon)
        HomeVC.tabBarItem = tabOneBarItem
        
        let ProfileVC = ProfileAssembler.make()
        let tabTwoBarItem2 = UITabBarItem(title: "Profile",
                                          image: .General.profileIcon,
                                          selectedImage: .General.selectedProfileIcon)
        ProfileVC.tabBarItem = tabTwoBarItem2
        
        self.viewControllers = [HomeVC, ProfileVC]
    }
}
