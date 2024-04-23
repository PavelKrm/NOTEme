//
//  UIButton+Styles.swift
//  NoteMe
//
//  Created by PavelKrm on 31.10.23.
//

import UIKit

extension UIButton {
    
    static func mapButton() -> UIButton {
        let button = UIButton()
        button.setBorder(width: 1.0, color: .systemBlue)
        button.cornerRadius = 5.0
//        button.clipsToBounds = true
        button.contentMode = .scaleAspectFill
        button.setBackgroundImage(.General.mapImage, for: .normal)
        return button
    }
    
    static func editButton() -> UIButton {
        let btn = UIButton()
        btn.setImage(.General.editIcon, for: .normal)
        return btn
    }
    
    static func yellowRoundedButton(_ title: String?) -> UIButton {
        
        let button = UIButton()
        button.backgroundColor = .appYellow
        button.cornerRadius = 5.0
        button.setTitle(title, for: .normal)
        button.setTitleColor(.appText, for: .normal)
        button.setTitleColor(.appText.withAlphaComponent(0.75),
                             for: .highlighted)
        button.titleLabel?.font = .appBoldFont.withSize(17.0)
        
        return button
    }
    
    static func appCancelButton() -> UIButton {
        
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitle("ResetPassVC_cancel_btn".localized, for: .normal)
        button.setBorder(width: 1.0, color: .appYellow)
        button.cornerRadius = 5.0
        button.setTitleColor(.appYellow, for: .normal)
        button.setTitleColor(.appYellow.withAlphaComponent(0.75),
                             for: .highlighted)
        button.titleLabel?.font = .appBoldFont.withSize(17.0)
        
        return button
    }
    
    static func underlineYellowButton(_ title: String) -> UIButton {
        
        return underlineButton(title,
                               color: .appYellow,
                               font: .appBoldFont.withSize(17.0))
    }
    
    static func underlineGrayButton(_ title: String) -> UIButton {
        
        return underlineButton(title,
                               color: .appGrayText,
                               font: .appBoldFont)
    }
    
    static func underlineButton(_ title: String,
                                color: UIColor,
                                font: UIFont
                                ) -> UIButton {
            
        let button = UIButton()
            
        button.backgroundColor = .clear
            
        let normalAttr: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: color,
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .underlineColor: color
            ]
        button.setAttributedTitle(
            .init(string: title, attributes: normalAttr), for: .normal
            )
            
        let highlightedAttr: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: color.withAlphaComponent(0.75),
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .underlineColor: color.withAlphaComponent(0.75)
            ]
        
        button.setAttributedTitle(
            .init(string: title, attributes: highlightedAttr),
            for: .highlighted
            )
            
        return button
    }
}
