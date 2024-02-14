//
//  HomeVM.swift
//  NoteMe
//
//  Created by PavelKrm on 29.11.23.
//

import UIKit
import Storage

protocol HomeAdapterProtocol: AnyObject {
    func reloadData(_ dtoList: [any DTODescription])
}

protocol HomeViewModelCoordinatorProtocol: AnyObject {}

final class HomeVM: HomeViewModelProtocol {
    
//    private let frcService: FRCService<DateNotificationDTO>
//    private let adapter: HomeAdapterProtocol
//    
//    init(frcService: FRCService<DateNotificationDTO>,
//         adapter: HomeAdapterProtocol) {
//        self.frcService = frcService
//        self.adapter = adapter
//        
//        bind()
//    }
    
//    private func bind() {
//        frcService.didChangeContent = { [weak adapter] dtoList in
//            adapter?.reloadData(dtoList)
//        }
//    }
    
}
