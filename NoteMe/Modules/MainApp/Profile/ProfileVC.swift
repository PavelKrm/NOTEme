//
//  ProfileVC.swift
//  NoteMe
//
//  Created by PavelKrm on 30.11.23.
//

import UIKit
import SnapKit

protocol ProfileViewModelProtocol {
    
    var catchEmail: ((String?) -> Void)? { get set }
    var catchExportInfo: ((String?) -> Void)? { get set }
    var buttons: [SettingsButton] { get }
    
    func getEmail()
    func notificationDidTap()
    func exportDidTap()
    func logoutDidTap()
}

final class ProfileVC: UIViewController {
    
    private lazy var accountView: UIView = .contentView()
    
    private lazy var settingsView: UIView = .contentView()
    
    private lazy var accountLbl: UILabel = .infoLabel(L10n.accountLbl,
                                                      with: 14.0,
                                                      font: .appBoldFont )
    
    private lazy var settingsLbl: UILabel = .infoLabel(L10n.settingsLbl,
                                                       with: 14.0,
                                                       font: .appBoldFont)
    private lazy var emailTitleLbl: UILabel = {
        let label = UILabel()
        label.text = L10n.emailLbl
        label.textColor = .appSuperLightGrayText
        label.font = .appFont.withSize(15.0)
        return label
    }()
    
    private lazy var emailLbl: UILabel = .infoLabel(nil,
                                                     with: 17.0)
    
    private lazy var settingsTableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .white
        tv.register(ProfileButtonCell.self,
                    forCellReuseIdentifier: ProfileButtonCell.identifier)
        tv.delegate = self
        tv.dataSource = self
        tv.isScrollEnabled = false
        return tv
    }()
    
    private var viewModel: ProfileViewModelProtocol
    
    init(viewModel: ProfileViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        setupTabBarItem()
        bind()
        viewModel.getEmail()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstraints()
    }
    
    private func bind() {
        
        viewModel.catchEmail = { [weak self] email in
            self?.emailLbl.text = email
        }
    }
    
    private func setupUI() {
        
        view.backgroundColor = .appGray
        
        view.addSubview(accountLbl)
        view.addSubview(accountView)
        view.addSubview(settingsLbl)
        view.addSubview(settingsView)
        
        accountView.addSubview(emailTitleLbl)
        accountView.addSubview(emailLbl)
        
        settingsView.addSubview(settingsTableView)
    }
    
    private func setupTabBarItem() {
        
        self.tabBarItem = UITabBarItem(title: L10n.tabBarItemTitle,
                                      image: .General.profileIcon,
                                      tag: .zero)
    }
    
    private func setupConstraints() {
        
        accountLbl.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(20.0)
            make.left.equalToSuperview().inset(20.0)
        }
        
        accountView.snp.makeConstraints { make in
            make.top.equalTo(accountLbl.snp.bottom).inset(-16.0)
            make.horizontalEdges.equalToSuperview().inset(20.0)
        }
        
        settingsLbl.snp.makeConstraints { make in
            make.top.equalTo(accountView.snp.bottom).inset(-16.0)
            make.left.equalToSuperview().inset(20.0)
        }
        
        settingsView.snp.makeConstraints { make in
            make.top.equalTo(settingsLbl.snp.bottom).inset(-16.0)
            make.horizontalEdges.equalToSuperview().inset(20.0)
        }
        
        emailTitleLbl.snp.makeConstraints { make in
            make.top.left.equalToSuperview().inset(16.0)
        }
        
        emailLbl.snp.makeConstraints { make in
            make.top.equalTo(emailTitleLbl.snp.bottom).inset(-4.0)
            make.horizontalEdges.equalToSuperview().inset(16.0)
            make.bottom.equalToSuperview().inset(16.0)
        }
        
        settingsTableView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview().inset(16.0)
            make.top.bottom.equalToSuperview().inset(4.0)
            make.height.equalTo(120.0)
        }
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource

extension ProfileVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return viewModel.buttons.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ProfileButtonCell.identifier,
            for: indexPath) as? ProfileButtonCell
        else { fatalError("noup") }
        
        cell.configure(with: viewModel.buttons[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            viewModel.notificationDidTap()
        } else if indexPath.row == 1 {
            viewModel.exportDidTap()
        } else {
            viewModel.logoutDidTap()
        }
    }
}

//MARK: - L10n

extension ProfileVC {
    private enum L10n {
        static let tabBarItemTitle = "ProfileVC_tabBarItem_Title".localized
        static let accountLbl = "ProfileVC_accountLbl_Title".localized
        static let settingsLbl = "ProfileVC_settingsLbl_Title".localized
        static let notifiBtnTitle = "ProfileVC_notifiBtn_Title".localized
        static let exportBtnTitle = "ProfileVC_exportBtn_Title".localized
        static let logoutBtnTitle = "ProfileVC_logoutBtn_Title".localized
        static let emailLbl = "ProfileVC_emailLbl_Title".localized
    }
}
