//
//  Date+Optional.swift
//  NoteMe
//
//  Created by PavelKrm on 9.04.24.
//

import Foundation

extension Date {
    
    init?(_ iInterval1970: TimeInterval?) {
        guard let iInterval1970 else { return nil }
        self.init(timeIntervalSince1970: iInterval1970)
    }
}
