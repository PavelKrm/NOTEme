//
//  HomeVM.swift
//  NoteMe
//
//  Created by PavelKrm on 29.11.23.
//

import UIKit
import Storage

protocol HomeFRCServiceUseCase {
    
    var fetchedDTOs: [any DTODescription] { get set }
    var didChangeContent: (([any DTODescription]) -> Void)? { get set }
}

protocol HomeStorageUseCase {
    
    func delete(dto: any DTODescription)
}

protocol HomeAdapterProtocol: AnyObject {
    
    func reloadData(_ dtoList: [any DTODescription])
    func makeTableView() -> UITableView
}

protocol HomeViewModelCoordinatorProtocol: AnyObject {}

final class HomeVM: HomeViewModelProtocol {
    
    private var frcService: FRCService<BaseNotificationDTO>
    private let adapter: HomeAdapterProtocol
    
    init(frcService: FRCService<BaseNotificationDTO>,
         adapter: HomeAdapterProtocol) {
        self.frcService = frcService
        self.adapter = adapter
        
        bind()
    }
    
    private func bind() {
        frcService.didChangeContent = { [weak adapter] dtoList in
            adapter?.reloadData(dtoList)
        }
    }
    
    func viewDidLoad() {
        
        frcService.startHandle()
        let dtos = frcService.fetchedDTOs
        adapter.reloadData(dtos)
    }
    
    func makeTableView() -> UITableView {
        adapter.makeTableView()
    }
    
}
