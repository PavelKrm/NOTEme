//
//  ProfileVM.swift
//  NoteMe
//
//  Created by PavelKrm on 30.11.23.
//

import UIKit
protocol ProfileCoordinatorProtocol {}

protocol ProfileAuthServiceUseCase {
    
    func logout() -> Bool
    func checkUserEmail(completion: @escaping(String?) -> Void)
}

protocol ProfileAlertServiceUseCase {
    
    func showOkAlert(title: String,
                     message: String,
                     okTitle: String,
                     cancelTitle: String)
//                   okHandler : (() -> Void)?)
}

final class ProfileVM: ProfileViewModelProtocol {
    
    var catchEmail: ((String?) -> Void)?
    var catchExportInfo: ((String?) -> Void)?
    private var userEmail: String?
    
    //MARK: - fix me please
    
    var buttons: [SettingsButton] = [
        SettingsButton.init(title: L10n.notifiBtnTitle,
                            logo: .General.notifiIcon),
        SettingsButton.init(title: L10n.exportBtnTitle,
                            logo: .General.exportIcon,
                            subTitle: "Never"),
        SettingsButton.init(title: L10n.logoutBtnTitle,
                            logo: .General.logoutIcon,
                            titleColor: .appRed)
    ]
    
    private let authService: ProfileAuthServiceUseCase
    private let alertService: ProfileAlertServiceUseCase
    
    init(authService: ProfileAuthServiceUseCase,
         alertService: ProfileAlertServiceUseCase) {
        self.alertService = alertService
        self.authService = authService
    }
    
    func getEmail() {
        authService.checkUserEmail { [weak self] email in
            self?.catchEmail?(email)
            self?.userEmail = email
        }

    }

    func notificationDidTap() {
        print(#function)
    }
    
    func exportDidTap() {
        print(#function)
    }
    
    func logoutDidTap() {
        
        alertService.showOkAlert(
            title: L10n.logoutAlertTitle,
            message: "\(L10n.logoutAlertMsg) \n\(userEmail ?? "")",
            okTitle: L10n.logoutAlertOkTitle,
            cancelTitle: L10n.logoutAlertCancelTitle)
//          { [weak self] in
//
////            let isLogout = self?.authService.logout()
////            
////            if let isLogout {
////                ParametersHelper.set(.authenticated, value: false)
////            }
//        }
    }
}

//MARK: - L10n

extension ProfileVM {
    private enum L10n {
        static let notifiBtnTitle = "ProfileVC_notifiBtn_Title".localized
        static let exportBtnTitle = "ProfileVC_exportBtn_Title".localized
        static let logoutBtnTitle = "ProfileVC_logoutBtn_Title".localized
        static let logoutAlertTitle = "ProfileVM_logoutAlert_Title".localized
        static let logoutAlertMsg = "ProfileVM_logoutAlert_Message".localized
        static let logoutAlertOkTitle = "ProfileVM_logoutAlert_OkTitle".localized
        static let logoutAlertCancelTitle = "ProfileVM_logoutAlert_CancelTitle".localized
    }
}
