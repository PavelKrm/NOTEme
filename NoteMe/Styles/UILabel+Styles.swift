//
//  UILabel+Styles.swift
//  NoteMe
//
//  Created by PavelKrm on 1.11.23.
//

import UIKit

extension UILabel {
    
    static func attrTextLabel(_ text: String?) -> UILabel {
    
        guard let text else { return UILabel() }
        let pattern = "•(.|\n|\r)*? -"
        let attrText = NSMutableAttributedString(string: text)
        attrText.addAttribute(.font,
                              value: UIFont.appFont.withSize(13.0),
                              range: NSRange(location: 0,
                                            length: attrText.length))
        let regex = try? NSRegularExpression(pattern: pattern,
                                             options: .caseInsensitive)
        if let matches = regex?.matches(in: text,
                                    options: [],
                                    range: NSRange(location: 0,
                                                   length: text.count)) as?
            [NSTextCheckingResult] {
            
            for match in matches {
                attrText.addAttribute(.font,
                                      value: UIFont.appBoldFont.withSize(13.0),
                                      range: match.range)
            }
        }
        
        let label: UILabel = UILabel()
        label.attributedText = attrText
        label.numberOfLines = 0
    
        return label
    }
    
    static func titleLabel(_ text: String?) -> UILabel {
        return textLabel(text: text,
                         font: .appBoldFont,
                         fontSize: 25.0,
                         textColor: .appText)
    }
    
    static func secondaryTitleLabel(_ text: String?) -> UILabel {
        return textLabel(text: text,
                         font: .appBoldFont,
                         fontSize: 17.0,
                         textColor: .appText)
    }
    
    static func infoLabel(_ text: String?,
                          with size: CGFloat,
                          font: UIFont = .appFont) -> UILabel {
        return self.textLabel(text: text,
                              font: font,
                              fontSize: size,
                              textColor: .appText,
                              lines: 2)
    }
    
   private static func textLabel(text: String?,
                       font: UIFont,
                       fontSize: CGFloat,
                       textColor: UIColor,
                                 lines: Int = 1) -> UILabel {
       
        let label = UILabel()
        label.text = text
        label.font = font.withSize(fontSize)
        label.textColor = textColor
        label.numberOfLines = lines
        
        return label
    }
}
