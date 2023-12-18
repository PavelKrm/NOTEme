//
//  ProfileVC.swift
//  NoteMe
//
//  Created by PavelKrm on 30.11.23.
//

import UIKit
import SnapKit

protocol ProfileViewModelProtocol {}

final class ProfileVC: UIViewController {
    
    private var viewModel: ProfileViewModelProtocol
    
    init(viewModel: ProfileViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        setupTabBarItem()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        
        view.backgroundColor = .appGray
    }
    
    private func setupTabBarItem() {
        
        self.tabBarItem = UITabBarItem(title: L10n.tabBarItemTitle,
                                      image: .General.profileIcon,
                                      tag: .zero)
    }
}

//MARK: - L10n

extension ProfileVC {
    private enum L10n {
        static let tabBarItemTitle = "ProfileVC_tabBarItem_Title".localized
    }
}
