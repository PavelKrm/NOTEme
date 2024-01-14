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
    
    private lazy var notifiButton: SettingsButton = {
        let button = SettingsButton()
        button.buttonTitle = L10n.notifiBtnTitle
        button.buttonImage = .General.notifiIcon
        button.buttonColor = .appText
        button.infoLabel = "Never"
        return button
    }()
    
    private lazy var exportButton: SettingsButton = {
        let button = SettingsButton()
        button.buttonTitle = L10n.exportBtnTitle
        button.buttonImage = .General.exportIcon
        button.buttonColor = .appText
        button.infoLabel = "Never"
        return button
    }()
    
    private lazy var logoutButton: SettingsButton = {
        let button = SettingsButton()
        button.buttonTitle = L10n.logoutBtnTitle
        button.buttonImage = .General.logoutIcon
        button.buttonColor = .appRed
        return button
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
        
        viewModel.catchExportInfo = { [weak self] exportInfo in
            self?.exportButton.infoLabel = exportInfo
        }
    }
    
    private func setupUI() {
        
        view.backgroundColor = .appGray
        accountView.backgroundColor = .white
        settingsView.backgroundColor = .white
        
        view.addSubview(accountLbl)
        view.addSubview(accountView)
        view.addSubview(settingsLbl)
        view.addSubview(settingsView)
        
        accountView.addSubview(emailTitleLbl)
        accountView.addSubview(emailLbl)
        
        settingsView.addSubview(logoutButton)
        settingsView.addSubview(exportButton)
        settingsView.addSubview(notifiButton)
        
      
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
        
        notifiButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16.0)
            make.top.equalToSuperview().inset(16.0)
        }
        
        exportButton.snp.makeConstraints { make in
            make.top.equalTo(notifiButton.snp.bottom).inset(-12.0)
            make.horizontalEdges.equalToSuperview().inset(16.0)
        }
        
        logoutButton.snp.makeConstraints { make in
            make.top.equalTo(exportButton.snp.bottom).inset(-12.0)
            make.horizontalEdges.equalToSuperview().inset(16.0)
            make.bottom.equalToSuperview().inset(16.0)
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
