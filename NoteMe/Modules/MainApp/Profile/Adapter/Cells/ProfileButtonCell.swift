//
//  ProfileTableViewCell.swift
//  NoteMe
//
//  Created by PavelKrm on 15.01.24.
//

import UIKit
import SnapKit

final class ProfileButtonCell: UITableViewCell {
    
    private lazy var icon: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.textColor = .appBlack
        label.font = .appFont.withSize(14.0)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var info: UILabel = {
        let label = UILabel()
        label.textColor = .appLightGrayText
        label.textAlignment = .right
        label.font = .appFont.withSize(12.0)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with button: ProfileSettingsRows) {
        self.icon.image = button.icon
        self.title.text = button.title
        self.info.text = button.infoText
        self.title.textColor = button == .logout ? .appRed : .appText
    }
    
    private func setupUI() {
        
        self.contentView.backgroundColor = .white
        self.contentView.addSubview(icon)
        self.contentView.addSubview(title)
        self.contentView.addSubview(info)
        
        separatorInset = UIEdgeInsets.init(top: 0,
                                           left: 16,
                                           bottom: 0,
                                           right: 16)
    }
    
    private func setupConstraints() {
        
        icon.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12.0)
            make.left.equalToSuperview().inset(16.0)
            make.size.equalTo(17.0)
            make.bottom.equalToSuperview().inset(12.0)
        }
        
        title.snp.makeConstraints { make in
            make.centerY.equalTo(icon.snp.centerY)
            make.left.equalTo(icon.snp.right).inset(-8.0)
        }
        
        info.snp.makeConstraints { make in
            make.centerY.equalTo(icon.snp.centerY)
            make.right.equalToSuperview().inset(16.0)
        }
    }
}
