//
//  UIView+Styles.swift
//  NoteMe
//
//  Created by PavelKrm on 1.11.23.
//

import UIKit

extension UIView {
    
    static func contentView() -> UIView {
        
        let view = UIView()
        view.backgroundColor = .appGray
        
        return view
    }
    
    static func signView() -> UIView {
        
        let view = UIView()
        view.cornerRadius = 5.0
        view.backgroundColor = .white
        
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize(width: 2.0, height: 4.0)
        view.layer.shadowRadius = 4.0
        view.layer.shadowColor = UIColor.appShadow.cgColor
        
        return view
    }
}
