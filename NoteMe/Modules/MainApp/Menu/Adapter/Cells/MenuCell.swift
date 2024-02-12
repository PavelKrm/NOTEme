//
//  MenuCell.swift
//  NoteMe
//
//  Created by PavelKrm on 12.02.24.
//

import UIKit
import SnapKit

final class MenuRowsCell: UITableViewCell {
    
    private lazy var icon: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.textColor = .appBlack
        label.font = .appFont.withSize(16.0)
        label.textAlignment = .left
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
    
    func configureActionMenu(with row: ActionsMunuRows) {
        self.icon.image = row.icon
        self.title.text = row.title
    }
    
    func configureAddNotifiMenu(with row: AddNotification) {
        self.icon.image = row.icon
        self.title.text = row.title
    }
    
    private func setupUI() {
        contentView.backgroundColor = .white
        contentView.addSubview(title)
        contentView.addSubview(icon)
        
        separatorInset = UIEdgeInsets.init(top: 0,
                                           left: 0,
                                           bottom: 0,
                                           right: 0)
    }
    private func setupConstraints() {
        
        title.snp.makeConstraints { make in

            make.left.equalToSuperview().inset(16.0)
            make.centerY.equalTo(icon.snp.centerY)
            make.width.equalTo(116.0)
        }
        
        icon.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8.0)
            make.size.equalTo(24.0)
            make.right.equalToSuperview().inset(16.0)
            make.left.equalTo(title.snp.right).inset(-8.0)
            make.bottom.equalToSuperview().inset(8.0)
        }
    }
}
