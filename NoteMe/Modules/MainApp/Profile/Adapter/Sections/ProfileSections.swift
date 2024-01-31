//
//  ProfileSections.swift
//  NoteMe
//
//  Created by PavelKrm on 23.01.24.
//

import UIKit

enum ProfileSections {
    
    case account(String?)
    case settings([ProfileSettingsRows])
    
    var numberOfRows: Int {
        switch self {
        case .settings(let rows): return rows.count
        default: return 1
        }
    }
    
    var headerText: String {
        switch self {
        case .account: return L10n.account
        case .settings(_): return L10n.settings
        }
    }
}

enum ProfileSettingsRows: CaseIterable {
     
    case notifications
    case export
    case logout
    
    var icon: UIImage {
        switch self {
        case .notifications: return .General.notifiIcon
        case .export: return .General.exportIcon
        case .logout: return .General.logoutIcon
        }
    }
    
    var title: String {
        switch self {
        case .notifications: return L10n.notifi
        case .export: return L10n.export
        case .logout: return L10n.logout
        }
    }
    
    var infoText: String? {
        switch self {
        case .export: return "Never"
        default: return nil
        }
    }
}

//MARK: L10n

extension ProfileSections {
    private enum L10n {
        static let account = "ProfileVC_accountLbl_Title".localized
        static let settings = "ProfileVC_settingsLbl_Title".localized
    }
}

extension ProfileSettingsRows {
    private enum L10n {
        
        static let notifi = "ProfileVC_notifiBtn_Title".localized
        static let export = "ProfileVC_exportBtn_Title".localized
        static let logout = "ProfileVC_logoutBtn_Title".localized
    }
}
