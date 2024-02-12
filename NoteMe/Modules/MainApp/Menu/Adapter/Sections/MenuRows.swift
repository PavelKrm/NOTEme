//
//  MenuRows.swift
//  NoteMe
//
//  Created by PavelKrm on 12.02.24.
//

import UIKit

enum MenuRows {
    case addNotificationMenu([AddNotification])
    case actionsMenu([ActionsMunuRows])
    
    var numberOfRows: Int {
        switch self {
        case .actionsMenu(let rows): return rows.count
        case .addNotificationMenu(let rows): return rows.count
        }
    }
}

enum ActionsMunuRows: CaseIterable {

    case edit
    case delete
    
    var icon: UIImage {
        switch self {
        case .edit: return .MenuIcons.edit
        case .delete: return .MenuIcons.delete
        }
    }
    
    var title: String {
        switch self {
        case .edit: return L10n.edit
        case .delete: return L10n.delete
        }
    }
}

enum AddNotification: CaseIterable {
    
    case calendar
    case location
    case timer
    
    var icon: UIImage {
        switch self {
        case .calendar: return .MenuIcons.calendar
        case .location: return .MenuIcons.location
        case .timer: return .MenuIcons.timer
        }
    }
    
    var title: String {
        switch self {
        case .calendar: return L10n.calendar
        case .location: return L10n.location
        case .timer: return L10n.timer
        }
    }
}

//MARK: - L10n

extension AddNotification {
    private enum L10n {
        
        static let calendar = "AddNotificationMenuVC_calendarRow_title".localized
        static let location = "AddNotificationMenuVC_locationRow_title".localized
        static let timer = "AddNotificationMenuVC_timerRow_title".localized
    }
}

extension ActionsMunuRows {
    private enum L10n {
        
        static let edit = "ActionsMenuVC_EditRow_title".localized
        static let delete = "ActionsMenuVC_DeleteRow_title".localized
    }
}
