//
//  MenuVM.swift
//  NoteMe
//
//  Created by PavelKrm on 12.02.24.
//

import UIKit

protocol MenuCoordinatorProtocol: AnyObject {
    
    func dismissedByUser()
    func addNotification(for type: AddNotification)
    func editRowDidTap()
    func deleteRowDidTap()
}

protocol MenuAdapterProtocol {

    var catchRowTap: ((MenuRows) -> Void)? { get set }
    
    func makeTableView() -> UITableView
    func reloadData(with rows: MenuRows)
}

final class MenuVM: MenuViewModelProtocol {
    
    var menu: MenuRows
    
    private weak var coordinator: MenuCoordinatorProtocol?
    private var adapter: MenuAdapterProtocol
    
    init(adapter: MenuAdapterProtocol,
         coordinator: MenuCoordinatorProtocol,
         menu: MenuRows) {
        self.adapter = adapter
        self.coordinator = coordinator
        self.menu = menu
        commonInit()
    }
    
    func makeTableView() -> UITableView {
        adapter.makeTableView()
    }
    
    func dismissedByUser() {
        coordinator?.dismissedByUser()
    }
    private func commonInit() {
        adapter.reloadData(with: menu)
        
        adapter.catchRowTap = { [weak self] rows in
            switch rows {
            case .addNotificationMenu(let row):
                switch row[0] {
                case .calendar: self?.createNotification(for: .calendar)
                case .location: self?.createNotification(for: .location)
                case .timer: self?.createNotification(for: .timer)
                }
            case .actionsMenu(let row):
                switch row[0] {
                case .edit: self?.editRowDidTap()
                case .delete: self?.deleteRowDidTap()
                }
            }
        }
    }
    
    private func createNotification(for type: AddNotification) {
        print(#function)
        coordinator?.addNotification(for: type)
    }
    
    private func editRowDidTap() {
        print(#function)
        coordinator?.editRowDidTap()
    }
    private func deleteRowDidTap() {
        print(#function)
        coordinator?.deleteRowDidTap()
    }
}
