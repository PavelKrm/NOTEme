//
//  UIImage+Consts.swift
//  NoteMe
//
//  Created by PavelKrm on 24.10.23.
//

import UIKit

extension UIImage {
    
    //MARK: - General
    enum General {
        
        static let logo: UIImage = .init(named: "logo")!
        static let onboardPlusIcon: UIImage = .init(named: "onboardPlusIcon")!
        static let onboardInfoImage: UIImage = .init(named: "onboardImage")!
        static let homeIcon: UIImage = .init(named: "homeIcon")!
        static let profileIcon: UIImage = .init(named: "profileIcon")!
        static let notifiIcon: UIImage = .init(named: "notifiIcon")!
        static let exportIcon: UIImage = .init(named: "exportIcon")!
        static let logoutIcon: UIImage = .init(named: "logoutIcon")!
        static let plus: UIImage = .init(named: "plus")!
    }
    
    enum MenuIcons {
        static let calendar: UIImage = .init(named: "calendarIcon")!
        static let location: UIImage = .init(named: "locationIcon")!
        static let timer: UIImage = .init(named: "timerIcon")!
        static let edit: UIImage = .init(named: "editIcon")!
        static let delete: UIImage = .init(named: "deleteIcon")!
    }
}
