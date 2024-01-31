//
//  ProfileAccountCell.swift
//  NoteMe
//
//  Created by PavelKrm on 23.01.24.
//

import UIKit
import SnapKit

final class ProfileAccountCell: UITableViewCell {
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.text = L10n.email
        label.textColor = .appSuperLightGrayText
        label.font = .appFont.withSize(15.0)
        return label
    }()
    
    private lazy var emailLbl: UILabel = .infoLabel(nil, with: 17.0)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with email: String?) {
        emailLbl.text = email
    }
    
    private func setupUI() {
        
        self.contentView.backgroundColor = .white
        self.contentView.addSubview(title)
        self.contentView.addSubview(emailLbl)
    }
    
    private func setupConstraints() {
        
        title.snp.makeConstraints { make in
            make.top.left.equalToSuperview().inset(16.0)
        }
        
        emailLbl.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).inset(-4.0)
            make.horizontalEdges.equalToSuperview().inset(16.0)
            make.bottom.equalToSuperview().inset(16.0)
        }
    }
}

//MARK: L10n
extension ProfileAccountCell {
    private enum L10n {
        static let email = "ProfileVC_emailLbl_Title".localized
    }
}
