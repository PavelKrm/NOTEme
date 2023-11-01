//
//  String+Locale.swift
//  NoteMe
//
//  Created by PavelKrm on 1.11.23.
//

import Foundation

extension String {
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
