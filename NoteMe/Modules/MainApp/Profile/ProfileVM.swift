//
//  ProfileVM.swift
//  NoteMe
//
//  Created by PavelKrm on 30.11.23.
//

import UIKit
protocol ProfileCoordinatorProtocol {}

protocol ProfileAuthServiceUseCaseProtocol {
    
    func logout() -> Bool
    func getUserEmail() -> String?
}

protocol ProfileAlertServiceUseCaseProtocol {
    
    func show(title: String?,
              message: String?,
              okTitle: String?,
              cancelTitle: String?,
              okHandler: (() -> Void)?)
}

protocol ProfileAdapterProtocol {
    
    func reloadData(with sections: [ProfileSections])
    func makeTableView() -> UITableView
}

final class ProfileVM: ProfileViewModelProtocol {
    
    func makeTableView() -> UITableView {
        adapter.makeTableView()
    }
    
    var sections: [ProfileSections] {
        return [
            .account(authService.getUserEmail()),
            .settings(ProfileSettingsRows.allCases)
        ]
    }
    
    private var userEmail: String?
    
    private let authService: ProfileAuthServiceUseCaseProtocol
    private let alertService: ProfileAlertServiceUseCaseProtocol
    private let adapter: ProfileAdapterProtocol
    
    init(authService: ProfileAuthServiceUseCaseProtocol,
         alertService: ProfileAlertServiceUseCaseProtocol,
         adapter: ProfileAdapterProtocol) {
        self.alertService = alertService
        self.authService = authService
        self.adapter = adapter
        
        commonInit()
    }

    func notificationDidTap() {
        print(#function)
    }
    
    func exportDidTap() {
        print(#function)
    }
    
    func logoutDidTap() {
        
        alertService.show(
            title: L10n.logoutAlertTitle,
            message: "\(L10n.logoutAlertMsg) \n\(userEmail ?? "")",
            okTitle: L10n.logoutAlertOkTitle,
            cancelTitle: L10n.logoutAlertCancelTitle) { [weak self] in

            if let isLogout = self?.authService.logout() {
                    
                if isLogout {
                    ParametersHelper.set(.authenticated, value: false)
                    print("Logout")
                } else {
                    print("error")
                }
            }
        }
    }
    
    private func commonInit() {
        adapter.reloadData(with: sections)
    }
}

//MARK: - L10n

extension ProfileVM {
    private enum L10n {
        static let logoutAlertTitle = "ProfileVM_logoutAlert_Title".localized
        static let logoutAlertMsg = "ProfileVM_logoutAlert_Message".localized
        static let logoutAlertOkTitle = "ProfileVM_logoutAlert_OkTitle".localized
        static let logoutAlertCancelTitle = "ProfileVM_logoutAlert_CancelTitle".localized
    }
}
