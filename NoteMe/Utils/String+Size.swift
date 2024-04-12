//
//  String+Size.swift
//  NoteMe
//
//  Created by PavelKrm on 12.04.24.
//

import UIKit

extension String {
    
    func mimimumWidthToDisplay(font: UIFont, height: CGFloat) -> CGFloat {
        
        let label = UILabel()
        label.text = self
        label.font = font
        return label
            .sizeThatFits(.init(width: .infinity, height: height))
            .width
    }
}
