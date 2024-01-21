//
//  ProfileTableViewCell.swift
//  NoteMe
//
//  Created by PavelKrm on 15.01.24.
//

import UIKit
import SnapKit

class ProfileButtonCell: UITableViewCell {
    
    static let identifier: String = "ProfileButtonCell"
    
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
    
    func configure(with button: SettingsButton) {
        self.icon.image = button.logo
        self.title.text = button.title
        self.info.text = button.subTitle
        if let color = button.titleColor {
            self.title.textColor = color
        }
    }
    
    private func setupUI() {
        self.contentView.backgroundColor = .white
        
        self.contentView.addSubview(icon)
        self.contentView.addSubview(title)
        self.contentView.addSubview(info)
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
            make.right.equalToSuperview()
        }
    }
}
