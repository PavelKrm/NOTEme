//
//  ProfileAdapter.swift
//  NoteMe
//
//  Created by PavelKrm on 23.01.24.
//

import UIKit

final class ProfileAdapter: NSObject, ProfileAdapterProtocol {
    
    var sections: [ProfileSections] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    private var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .insetGrouped)
        tv.backgroundColor = .clear
        tv.isScrollEnabled = false
        tv.separatorStyle = .singleLine
        return tv
    }()
    
    override init() {
        super.init()
        setupTableView()
    }
    
    private func setupTableView() {

        tableView.register(ProfileButtonCell.self,
                           forCellReuseIdentifier: "\(ProfileButtonCell.self)")
        tableView.register(ProfileAccountCell.self,
                           forCellReuseIdentifier: "\(ProfileAccountCell.self)")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    //MARK: - ProfileAdapterProtocol
    
    var cathRowTap: ((ProfileSettingsRows) -> Void)?
    
    func reloadData(with sections: [ProfileSections]) {
        self.sections = sections
    }
    
    func makeTableView() -> UITableView {
        return tableView
    }
}

//MARK: - UITableViewDataSource

extension ProfileAdapter: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        let sectionType = sections[section]
        return sectionType.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        var sectionsType = sections[indexPath.section]
        switch sectionsType {
        case .settings(let row):
            cathRowTap?(row[indexPath.row])
        default: break
        }
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section = sections[indexPath.section]
        switch section {
        case .account(let email):
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "\(ProfileAccountCell.self)",
                for: indexPath) as? ProfileAccountCell
            cell?.configure(with: email)
            
            return cell ?? .init()
            
        case .settings(let rows):
            
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "\(ProfileButtonCell.self)",
                for: indexPath) as? ProfileButtonCell
            
            cell?.configure(with: rows[indexPath.row])
            return cell ?? .init()
        }
    }
}

//MARK: - UITableViewDelegate

extension ProfileAdapter: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   viewForHeaderInSection section: Int) -> UIView? {
        
        let sectionType = sections[section]
        let header = ProfileSectionHeader()
        header.text = sectionType.headerText
        return header
    }
}
