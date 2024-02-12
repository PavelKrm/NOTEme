//
//  MenuAdapter.swift
//  NoteMe
//
//  Created by PavelKrm on 12.02.24.
//

import UIKit

final class MenuAdapter: NSObject, MenuAdapterProtocol {
    
    var rows: [MenuRows] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    private var tableView: UITableView = {
        let tv = UITableView()
        tv.isScrollEnabled = false
        return tv
    }()
    
    override init() {
        super.init()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.register(MenuRowsCell.self)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    //MARK: - ProfileAdapterProtocol
    
    var catchRowTap: ((MenuRows) -> Void)?
    
    func reloadData(with menu: MenuRows) {
        switch menu {
        case .actionsMenu(_): self.rows = [
            .actionsMenu(ActionsMunuRows.allCases)
            ]
        case .addNotificationMenu(_): self.rows = [ .addNotificationMenu(AddNotification.allCases)
                                                    ]
        }
    }
    
    func makeTableView() -> UITableView {
        return tableView
    }
}

//MARK: - UITableViewDataSource

extension MenuAdapter: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        let sectionType = rows[section]
        return sectionType.numberOfRows
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let menu = rows[indexPath.section]
        switch menu {
        case .addNotificationMenu(let row):
           
            let cell: MenuRowsCell? = tableView.dequeue(at: indexPath)
            cell?.configureAddNotifiMenu(with: row[indexPath.row])
            
            return cell ?? .init()
            
        case .actionsMenu(let row):
            let cell: MenuRowsCell? = tableView.dequeue(at: indexPath)
            cell?.configureActionMenu(with: row[indexPath.row])
            return cell ?? .init()
        }
    }
}

//MARK: - UITableViewDelegate

extension MenuAdapter: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let menuType = rows[indexPath.section]
        switch menuType {
        case .addNotificationMenu(let row):
            catchRowTap?(.addNotificationMenu([row[indexPath.row]]))
        case .actionsMenu(let row):
            catchRowTap?(.actionsMenu([row[indexPath.row]]))
        }
    }
}
