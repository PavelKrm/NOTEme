//
//  TimerNotificationCell.swift
//  NoteMe
//
//  Created by PavelKrm on 27.02.24.
//

import UIKit
import SnapKit
import Storage

final class TimerNotificationCell: UITableViewCell {
    
    private lazy var view: UIView = .contentView()
    
    private lazy var icon: UIImageView = {
        let image = UIImageView()
        image.image = .General.timerIcon
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
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var timerLabel: TimerLabel = TimerLabel()
    
    private lazy var button: UIButton =
        .editButton()
        .withAction(self, #selector(editButtondidTap))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(dto: TimerNotificationDTO) {
        titleLabel.text = dto.title
        subtitleLabel.text = dto.subtitle
        timerLabel.interval = dto.timeLeft
        timerLabel.date = dto.date
    }
    
    @objc private func editButtondidTap() {}
    
    private func setupUI() {
        
        contentView.backgroundColor = .appGray
        contentView.addSubview(view)
        
        view.addSubview(icon)
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(button)
        view.addSubview(timerLabel)
    }
    
    private func setupConstraints() {
        
        view.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20.0)
            make.top.bottom.equalToSuperview().inset(5.0)
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
        
        timerLabel.snp.makeConstraints { make in
            make.top.equalTo(icon.snp.bottom).inset(-8.0)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(16.0)
        }
    }
    
}
