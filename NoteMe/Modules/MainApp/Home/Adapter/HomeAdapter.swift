//
//  HomeAdapter.swift
//  NoteMe
//
//  Created by PavelKrm on 27.02.24.
//

import UIKit
import Storage

final class HomeAdapter: NSObject, HomeAdapterProtocol {
    
    private var tableView: UITableView = {
        let tv = UITableView()
        tv.separatorStyle = .none
        tv.backgroundColor = .clear
        return tv
    }()
    
    private var dtos: [any DTODescription] = []
    
    override init() {
        super.init()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.register(DateNotificationCell.self)
        tableView.register(TimerNotificationCell.self)
        tableView.register(LocationNotificationCell.self)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    //MARK: - HomeAdapterProtocol
    
    func reloadData(_ dtoList: [any DTODescription]) {
        self.dtos = dtoList
        tableView.reloadData()
    }
    
    func makeTableView() -> UITableView {
        return tableView
    }
    
}

//MARK: - UITableViewDataSource

extension HomeAdapter: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dtos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dto = dtos[indexPath.row]
        switch dto {
        case is DateNotificationDTO:
            let cell: DateNotificationCell? = tableView.dequeue(at: indexPath)
            cell?.configure(dto: dto as! DateNotificationDTO)
            return cell ?? .init()
        case is TimerNotificationDTO:
            let cell: TimerNotificationCell? = tableView.dequeue(at: indexPath)
            return cell ?? .init()
        case is LocationNotidicationDTO:
            let cell: LocationNotificationCell? = tableView.dequeue(at: indexPath)
            return cell ?? .init()
        default:
            return .init()
        }
    }
}

//MARK: - UITableViewDelegate

extension HomeAdapter: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
