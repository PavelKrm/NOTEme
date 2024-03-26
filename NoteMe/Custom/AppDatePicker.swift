//
//  AppDatePicker.swift
//  NoteMe
//
//  Created by PavelKrm on 16.02.24.
//

import UIKit
import SnapKit

protocol AppDatePickerDelegate {
    func pickerDateSelected()
    func cancelDidTap()
    func doneDidTap()
}

final class AppDatePicker: UIDatePicker {
    
//    private lazy var datePicker: UIDatePicker = {
//        let picker = UIDatePicker()
//        picker.preferredDatePickerStyle = .inline
//        picker.datePickerMode = .date
//        return picker
//    }()
//    
//    override init(height: CGFloat) {
//        super.init(frame: CGRect(x: 0,
//                                 y: 0,
//                                 width: height,
//                                 height: <#T##CGFloat#>))
//    }
    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
}
