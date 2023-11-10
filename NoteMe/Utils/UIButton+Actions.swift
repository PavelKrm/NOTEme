//
//  UIButton+Actions.swift
//  NoteMe
//
//  Created by PavelKrm on 10.11.23.
//

import UIKit

extension UIButton {
    
    @discardableResult
    func withAction(_ target: Any?,
                    _ selector: Selector,
                    forEvent: UIControl.Event = .touchUpInside) -> UIButton {
        self.addTarget(target, action: selector, for: forEvent)
        
        return self
    }
}
