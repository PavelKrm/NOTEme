//
//  MenuVM.swift
//  NoteMe
//
//  Created by PavelKrm on 12.02.24.
//

import UIKit

protocol MenuCoordinatorProtocol: AnyObject {}

protocol MenuAdapterProtocol {
    
    var catchRowTap: ((AddNotificationMenuRows) -> Void)? { get set }
    
    func makeTableView() -> UITableView
    func reloadData(with sections: [AddNotificationMenuRows])
}

final class AddMenuVM: AddMenuViewModelProtocol {
    
    var rows: [AddNotificationMenuRows] {
        return AddNotificationMenuRows.allCases
    }
    
    private var adapter: MenuAdapterProtocol
    private weak var coordinator: MenuCoordinatorProtocol?
    
    init(adapter: MenuAdapterProtocol,
         coordinator: MenuCoordinatorProtocol) {
        self.adapter = adapter
        self.coordinator = coordinator
        
        commonInit()
        bind()
    }
    
    func makeTableView() -> UITableView {
        adapter.makeTableView()
    }
    
    private func commonInit() {
        adapter.reloadData(with: rows)
    }
    
    private func bind() {
        adapter.catchRowTap = { [weak self] row in
            switch row {
            case .calendar: self?.calendarRowDidTap()
            case .location: self?.locationRowDidTap()
            case .timer: self?.timerRowDidTap()
            }
        }
    }
    
    private func calendarRowDidTap() {}
    private func locationRowDidTap() {}
    private func timerRowDidTap() {}
}
