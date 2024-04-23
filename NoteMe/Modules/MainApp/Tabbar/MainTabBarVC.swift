//
//  MainTabBarVC.swift
//  NoteMe
//
//  Created by PavelKrm on 18.12.23.
//

import UIKit
import SnapKit

protocol MainTabBarViewModelProtokol {
    func openMenu(with view: UIView)
}

final class MainTabBarVC: UITabBarController {
    
    private lazy var plusButton: UIButton = {
        let button = UIButton()
        button.setImage(.General.plus, for: .normal)
        button.layer.cornerRadius = button.bounds.height / 2
        button.addTarget(self,
                         action: #selector(showMenu),
                         for: .touchUpInside)
        return button
    }()
    
    private var viewModel: MainTabBarViewModelProtokol
    
    init(viewModel: MainTabBarViewModelProtokol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
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
        view.addSubview(plusButton)
        view.backgroundColor = .white
        
        tabBar.tintColor = .appYellow
        tabBar.backgroundColor = .appBlack
        tabBar.unselectedItemTintColor = .appGray
    }
    
    private func setupConstraints() {
        
        plusButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(tabBar.snp.top)
            make.size.equalTo(50.0)
        }
    }
    
    @objc private func showMenu() {
        viewModel.openMenu(with: plusButton)
    }
}
