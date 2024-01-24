//
//  ProfileVC.swift
//  NoteMe
//
//  Created by PavelKrm on 30.11.23.
//

import UIKit
import SnapKit

protocol ProfileViewModelProtocol {
    
    func makeTableView() -> UITableView
}

final class ProfileVC: UIViewController {
    
    private lazy var contentView: UIView = .backgroundView()
    
    private lazy var buttonsTableView: UITableView = viewModel.makeTableView()
    
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
        setupConstraints()
    }
    
    private func setupUI() {
        
        view.backgroundColor = .appGray
        view.addSubview(contentView)
        
        contentView.addSubview(buttonsTableView)
    }
    
    private func setupTabBarItem() {
        self.tabBarItem = UITabBarItem(title: L10n.tabBarItemTitle,
                                      image: .General.profileIcon,
                                      tag: .zero)
    }
    
    private func setupConstraints() {
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
        
        buttonsTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16.0)
        }
    }
}

//MARK: - L10n

extension ProfileVC {
    private enum L10n {
        static let tabBarItemTitle = "ProfileVC_tabBarItem_Title".localized
        static let emailLbl = "ProfileVC_emailLbl_Title".localized
    }
}

