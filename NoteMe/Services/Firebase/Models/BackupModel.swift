//
//  BackupModel.swift
//  NoteMe
//
//  Created by PavelKrm on 9.04.24.
//

import Foundation
import Storage

struct BackupModel: Codable {
    
    private let dto: any DTODescription
    
    enum BackupErrors: Error {
        case notSupportedBackupTupe
    }
    
    enum TypeDTO: String, Codable {
        case date = "date"
        case timer = "timer"
        case location = "location"
    }
    
    init(dto: any DTODescription) {
        self.dto = dto
    }
    
    init(from decoder: any Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(TypeDTO.self, forKey: .type)
        let id = try container.decode(String.self, forKey: .id)
        let date = try container.decode(Double.self, forKey: .date)
        let title = try container.decode(String.self, forKey: .title)
        let subtitle = try container.decodeIfPresent(String.self,
                                                     forKey: .subtitle)
        let completedDate = try container.decodeIfPresent(Double.self,
                                                           forKey: .completedDate)
        switch type {
        case .date:
            let targetDate = try container.decode(Double.self, forKey: .targetDate)
            
            let dateDTO = DateNotificationDTO(
                date: Date(timeIntervalSince1970: date),
                id: id,
                title: title,
                subtitle: subtitle,
                completedDate: Date(completedDate),
                targetDate: Date(timeIntervalSince1970: targetDate)
            )
            
            self.dto = dateDTO
            return
            
        case .timer:
            let timeLeft = try container.decodeIfPresent(Int.self, forKey: .timeLeft)
            
            let timerDTO = TimerNotificationDTO(
                date: Date(timeIntervalSince1970: date),
                id: id,
                subtitle: subtitle,
                title: title,
                completedDate: Date(completedDate),
                timeLeft: timeLeft ?? 0
            )
            
            self.dto = timerDTO
            return
            
        case .location:
            let latSpan = try container.decode(Double.self, forKey: .latSpan)
            let longSpan = try container.decode(Double.self, forKey: .longSpan)
            let latCenter = try container.decode(Double.self, forKey: .latCenter)
            let longCenter = try container.decode(Double.self, forKey: .longCenter)
            let imagePathStr = try container.decode(String.self, forKey: .imagePathStr)
            
            let locationDTO = LocationNotidicationDTO(
                date: Date(timeIntervalSince1970: date),
                id: id,
                title: title,
                subtitle: subtitle,
                completedDate: Date(completedDate),
                latSpan: latSpan,
                longSpan: longSpan,
                latCenter: latCenter,
                longCenter: longCenter,
                imagePathStr: imagePathStr
            )
            
            self.dto = locationDTO
            return
        }
        
        throw BackupErrors.notSupportedBackupTupe
    }
    
    enum CodingKeys: CodingKey {
        // main attributes
        case type
        case id
        case date
        case title
        case subtitle
        case completedDate
        // date attributes
        case targetDate
        // timer attributes
        case timeLeft
        // location attributes
        case latSpan
        case longSpan
        case latCenter
        case longCenter
        case imagePathStr
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        //main
        try container.encode(dto.id, forKey: .id)
        try container.encode(dto.date.timeIntervalSince1970, forKey: .date)
        try container.encode(dto.title, forKey: .title)
        try container.encode(dto.subtitle, forKey: .subtitle)
        
        if let completedDate = dto.completedDate {
            try container.encode(completedDate, forKey: .completedDate)
        }
        
        if let dateDto = dto as? DateNotificationDTO {
            // date
            try container.encode(TypeDTO.date, forKey: .type)
            try container.encode(dateDto.targetDate.timeIntervalSince1970,
                                 forKey: .targetDate)
            
        } else if let timerDto = dto as? TimerNotificationDTO {
            // timer
            try container.encode(TypeDTO.timer, forKey: .type)
            try container.encode(timerDto.timeLeft, forKey: .timeLeft)
            
        } else if let locationDto = dto as? LocationNotidicationDTO {
            // location
            try container.encode(TypeDTO.location, forKey: .type)
            try container.encode(locationDto.latSpan, forKey: .latSpan)
            try container.encode(locationDto.longSpan, forKey: .longSpan)
            try container.encode(locationDto.latCenter, forKey: .latCenter)
            try container.encode(locationDto.longCenter, forKey: .longCenter)
            try container.encode(locationDto.imagePathStr, forKey: .imagePathStr)
        }
    }
    
    func buildDict() -> [String: Any]? {
        guard
            let data = try? JSONEncoder().encode(self),
                let dict = try? JSONSerialization.jsonObject(
                    with: data,
                    options: .fragmentsAllowed
                )
        else { return nil }
        
        return dict as? [String: Any]
    }
}
