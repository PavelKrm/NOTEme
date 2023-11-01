//
//  UILabel+Styles.swift
//  NoteMe
//
//  Created by PavelKrm on 1.11.23.
//

import UIKit

extension UILabel {
    
    static func titleLabel(_ text: String?) -> UILabel {
        
        let label = UILabel()
        label.text = text
        label.font = .appBoldFont.withSize(25.0)
        label.textColor = .appText
        
        return label
    }
    
    static func secondaryTitleLabel(_ text: String?) -> UILabel {
        
        let label = UILabel()
        label.text = text
        label.font = .appBoldFont.withSize(17.0)
        label.textColor = .appText
            
        return label
    }
    
    
}
