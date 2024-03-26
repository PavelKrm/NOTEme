//
//  UIDdatePicker+Styles.swift
//  NoteMe
//
//  Created by PavelKrm on 16.02.24.
//

import UIKit

extension UIDatePicker {
    
    static func appDatePicker(mode: UIDatePicker.Mode,
                              target: UIViewController, action: Selector) -> UIDatePicker {
        let picker = UIDatePicker()
        picker.addTarget(target, action: action, for: .valueChanged)
        picker.datePickerMode = mode
        picker.preferredDatePickerStyle = .wheels
        picker.backgroundColor = .white
        picker.tintColor = .appText
        picker.inputView?.backgroundColor = .appBlack
        
        return picker
    }
}
