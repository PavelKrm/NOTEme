//
//  DateNotificationCell.swift
//  NoteMe
//
//  Created by PavelKrm on 27.02.24.
//

import UIKit
import SnapKit
import Storage

protocol ActionMenuDelegate: AnyObject {
    
    func openActionMenu(for view: UIView, with dto: any DTODescription)
}

final class DateNotificationCell: UITableViewCell {
    
    private var dto: DateNotificationDTO?
    
    private lazy var dateView: DateView = DateView()
    
    private lazy var view: UIView = .contentView()
    
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
    
    private lazy var button: UIButton =
        .editButton()
        .withAction(self, #selector(editButtondidTap))
    
    weak var delegate: ActionMenuDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        delegate = nil
    }
    
    func configure(dto: DateNotificationDTO) {
        
        self.dto = dto
        
        titleLabel.text = dto.title
        subtitleLabel.text = dto.subtitle
        
        dateView.day = dto.targetDate.formatted(Date.FormatStyle().day(.twoDigits))
        dateView.month = dto.targetDate.formatted(Date.FormatStyle().month(.abbreviated))
    }
    
    @objc private func editButtondidTap() {
        guard let dto else { return }
        delegate?.openActionMenu(for: button, with: dto)
    }
    
    private func setupUI() {
        contentView.backgroundColor = .appGray
        
        contentView.addSubview(view)
        view.addSubview(dateView)
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(button)
        
        dateView.layer.cornerRadius = 5.0
    }
    
    private func setupConstraints() {
        
        view.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20.0)
            make.top.bottom.equalToSuperview().inset(5.0)
        }
        
        dateView.snp.makeConstraints { make in
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
            make.left.equalTo(dateView.snp.right).inset(-8.0)
            make.right.equalTo(button.snp.left).inset(-8.0)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).inset(-4.0)
            make.left.equalTo(dateView.snp.right).inset(-8.0)
            make.right.equalTo(button.snp.left).inset(-8.0)
        }
    }
}
