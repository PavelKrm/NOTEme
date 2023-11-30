//
//  UITextView+Styles.swift
//  NoteMe
//
//  Created by PavelKrm on 29.11.23.
//

import UIKit

extension UITextView {
    
    static func onboardInfoView() -> UITextView {
        
        let textView = UITextView()
        textView.text = "TEST TEXT"
        
        textView.font = .appFont.withSize(13.0)
        textView.textColor = .appText
        
        return textView
    }
}
