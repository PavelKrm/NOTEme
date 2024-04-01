//
//  TimeInterval+String.swift
//  NoteMe
//
//  Created by PavelKrm on 2.04.24.
//
import Foundation

extension TimeInterval {
    
    func timeIntervalFromTimeLeft(time: Int) -> Int {
        let seconds = -NSInteger(self)
        let timeLeft = time - seconds
        return timeLeft
    }
}
