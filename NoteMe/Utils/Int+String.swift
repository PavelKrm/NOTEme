//
//  Int+String.swift
//  NoteMe
//
//  Created by PavelKrm on 2.04.24.
//

import Foundation

extension Int {
    
    func stingFromSeconds() -> String {
        
        let interval = self

        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        let hours = (interval / 3600)

        return String(format: "%0.2d:%0.2d:%0.2d",hours,minutes,seconds)
    }
}
