//
//  LocationNotificationCell.swift
//  NoteMe
//
//  Created by PavelKrm on 27.02.24.
//

import UIKit

final class LocationNotificationCell: UITableViewCell {
    
    private lazy var icon: UIImageView = {
        let image = UIImageView()
        image.image = .General.locationIcon
        image.layer.cornerRadius = 5.0
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .appBlack
        label.font = .appBoldFont.withSize(15.0)
        label.text = "test text"
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .appGrayText
        label.font = .appFont.withSize(15.0)
        label.text = "test subtitle text"
        return label
    }()
    
    private lazy var button: UIButton =
        .editButton()
        .withAction(self, #selector(editButtondidTap))
    
    @objc private func editButtondidTap() {}
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        contentView.addSubview(icon)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(button)
    }
    
    private func setupConstraints() {
        
        icon.snp.makeConstraints { make in
            make.size.equalTo(50.0)
            make.top.left.bottom.equalToSuperview().inset(16.0)
        }
        
        button.snp.makeConstraints { make in
            make.top.right.equalToSuperview().inset(16.0)
            make.width.equalTo(18.0)
            make.height.equalTo(4.0)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16.0)
            make.left.equalTo(icon.snp.right).inset(8.0)
            make.right.equalTo(button.snp.left).inset(8.0)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).inset(4.0)
            make.left.equalTo(icon.snp.right).inset(8.0)
            make.right.equalTo(button.snp.left).inset(8.0)
        }
    }
}
