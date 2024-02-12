//
//  HomeVC.swift
//  NoteMe
//
//  Created by PavelKrm on 29.11.23.
//

import UIKit
import SnapKit
import Storage

protocol HomeViewModelProtocol {}

final class HomeVC: UIViewController {
    
    private var viewModel: HomeViewModelProtocol
    
    init(viewModel: HomeViewModelProtocol) {
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
                                      image: .General.homeIcon,
                                      tag: .zero)
    }
}

//MARK: - L10n

extension HomeVC {
    private enum L10n {
        static let tabBarItemTitle = "HomeVC_tabBarItem_Title".localized
    }
}
