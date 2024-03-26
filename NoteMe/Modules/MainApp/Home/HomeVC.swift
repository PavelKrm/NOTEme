//
//  HomeVC.swift
//  NoteMe
//
//  Created by PavelKrm on 29.11.23.
//

import UIKit
import SnapKit
import Storage

protocol HomeViewModelProtocol {
    func viewDidLoad()
    func makeTableView() -> UITableView
}

final class HomeVC: UIViewController {
    
    private lazy var contenView: UIView = .backgroundView()
    private lazy var tableView: UITableView = viewModel.makeTableView()
    
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
        viewModel.viewDidLoad()
        
        setupUI()
        setupConstraints()
    }
    
    private func setupUI() {
        
        view.backgroundColor = .appBlack
        view.addSubview(contenView)
        
        contenView.addSubview(tableView)
    }
    
    private func setupTabBarItem() {
        
        self.tabBarItem = UITabBarItem(title: L10n.tabBarItemTitle,
                                      image: .General.homeIcon,
                                      tag: .zero)
    }
    
    private func setupConstraints() {
        
        contenView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
        
        tableView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(15.0)
            make.top.bottom.equalToSuperview().inset(16.0)
        }
    }
}

//MARK: - L10n

extension HomeVC {
    private enum L10n {
        static let tabBarItemTitle = "HomeVC_tabBarItem_Title".localized
    }
}
