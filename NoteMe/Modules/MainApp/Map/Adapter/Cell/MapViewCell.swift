//
//  SearchMapCell.swift
//  NoteMe
//
//  Created by PavelKrm on 22.04.24.
//

import Foundation
import UIKit
import SnapKit

final class SearchMapCell: UITableViewCell {
    
    private lazy var icon: UIImageView = {
        let icon = UIImageView()
        icon.image = .General.mapPin
        return icon
    }()
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.font = .appFont.withSize(14.0)
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var distance: UILabel = {
        let label = UILabel()
        label.font = .appFont.withSize(12.0)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = .appLightGrayText
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        title.text = nil
        distance.text = nil
    }
    
    func configure(title: String, distance: String) {
        self.title.text = title
        self.distance.text = distance
    }
    
    private func setupUI() {
        contentView.addSubview(icon)
        contentView.addSubview(title)
        contentView.addSubview(distance)
    }
    
    private func setupConstraints() {
        
        icon.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(11.0)
            make.left.equalToSuperview().inset(20.0)
            make.height.equalTo(23.0)
            make.width.equalTo(16.0)
        }
        
        title.snp.makeConstraints { make in
            make.centerY.equalTo(icon.snp.centerY)
            make.left.equalTo(icon.snp.right).offset(8.0)
        }
        
        distance.snp.makeConstraints { make in
            make.centerY.equalTo(icon.snp.centerY)
            make.right.equalToSuperview().inset(20.0)
        }
    }
}
