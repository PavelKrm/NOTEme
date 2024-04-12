//
//  NotificationFilterCell.swift
//  NoteMe
//
//  Created by PavelKrm on 12.04.24.
//

import UIKit
import SnapKit

final class NotificationFilterCell: UICollectionViewCell {
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.font = .appFont.withSize(17.0)
        label.textAlignment = .center
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            setSelectedUI()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with type: FilterType) {
        title.text = type.title
    }
    
    private func setSelectedUI() {
        
        if isSelected {
            contentView.backgroundColor = .appYellow
            title.font = .appBoldFont.withSize(17.0)
        } else {
            contentView.backgroundColor = .appDarkGray
            title.font = .appFont.withSize(17.0)
        }
    }
    
    private func setupUI() {
        
        contentView.addSubview(title)
        contentView.backgroundColor = .appDarkGray
        contentView.cornerRadius = 5.0
    }
    
    private func setupConstraints() {
        
        title.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
