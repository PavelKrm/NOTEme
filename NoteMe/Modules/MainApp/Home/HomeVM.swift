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
    
    var filterDidSelect: ((FilterType) -> Void)? { get set }
    var openMenu: ((ActionMenuProperty) -> Void)? { get set }
    
    func reloadData(_ dtoList: [any DTODescription])
    func makeTableView() -> UITableView
}

protocol HomeViewModelCoordinatorProtocol: AnyObject {
    
    var deleteDtoByUser: ((any DTODescription) -> Void)? { get set }
    
    func openActionMenu(for view: UIView, with dto: any DTODescription)
}

final class HomeVM: HomeViewModelProtocol {
    
    private let adapter: HomeAdapterProtocol
    private let storage: HomeStorageUseCase
    private var frcService: FRCService<BaseNotificationDTO>
    private weak var coordinator: HomeViewModelCoordinatorProtocol?
    
    private var selectedFilter: FilterType = .all {
        didSet {
            adapter.reloadData(filterResults())
        }
    }
    
    init(frcService: FRCService<BaseNotificationDTO>,
         adapter: HomeAdapterProtocol,
         coordinator: HomeViewModelCoordinatorProtocol,
         storage: HomeStorageUseCase) {
        self.frcService = frcService
        self.adapter = adapter
        self.coordinator = coordinator
        self.storage = storage
        
        bind()
    }
    
    private func bind() {
        frcService.didChangeContent = { [weak self] _ in
            self?.adapter.reloadData(self?.filterResults() ?? [])
        }
        
        adapter.filterDidSelect = { [weak self] type in
            self?.selectedFilter = type
        }
        
        adapter.openMenu = { [weak self] property in
            self?.coordinator?.openActionMenu(for: property.view,
                                              with: property.dto)
        }
        
        coordinator?.deleteDtoByUser = { [weak self] dto in
            self?.storage.delete(dto: dto)
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
    
    private func filterResults() -> [any DTODescription] {
        
        return frcService.fetchedDTOs.filter { dto in
            switch selectedFilter {
            case .date: return dto is DateNotificationDTO
            case .location: return dto is LocationNotidicationDTO
            case .timer: return dto is TimerNotificationDTO
            default: return true
                
            }
        }
    }
}
