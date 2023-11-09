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
        
        return view
    }
}
