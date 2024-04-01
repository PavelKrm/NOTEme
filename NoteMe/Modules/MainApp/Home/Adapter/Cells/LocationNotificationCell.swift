//
//  LocationNotificationCell.swift
//  NoteMe
//
//  Created by PavelKrm on 27.02.24.
//

import UIKit
import SnapKit
import Storage

final class LocationNotificationCell: UITableViewCell {
    
    private lazy var view: UIView = .contentView()
    
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
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .appDarkGrayText
        label.font = .appFont.withSize(13.0)
        return label
    }()
    
    private lazy var screenShot: UIImageView = {
        let imageView = UIImageView()
        imageView.cornerRadius = 5.0
        imageView.contentMode = .scaleAspectFill
        imageView.image = .General.mapImage
        return imageView
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
    
    func configure(dto: LocationNotidicationDTO) {
        
        titleLabel.text = dto.title
        subtitleLabel.text = dto.subtitle
        screenShot.image = FileService().loadImage(id: dto.id)
    }
    
    private func setupUI() {
        
        contentView.backgroundColor = .appGray
        contentView.addSubview(view)
        
        view.addSubview(icon)
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(button)
        view.addSubview(screenShot)
    }
    
    private func setupConstraints() {
        
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(5.0)
        }
        
        icon.snp.makeConstraints { make in
            make.size.equalTo(50.0)
            make.top.left.equalToSuperview().inset(16.0)
        }
        
        button.snp.makeConstraints { make in
            make.top.right.equalToSuperview().inset(16.0)
            make.width.equalTo(18.0)
            make.height.equalTo(4.0)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16.0)
            make.left.equalTo(icon.snp.right).inset(-8.0)
            make.right.equalTo(button.snp.left).inset(8.0)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).inset(-4.0)
            make.left.equalTo(icon.snp.right).inset(-8.0)
            make.right.equalTo(button.snp.left).inset(8.0)
        }
        
        screenShot.snp.makeConstraints { make in
            make.top.equalTo(icon.snp.bottom).inset(-8.0)
            make.horizontalEdges.equalToSuperview().inset(16.0)
            make.bottom.equalToSuperview().inset(16.0)
            make.height.equalTo(147.0)
        }
    }
}
