//
//  File.swift
//  NoteMe
//
//  Created by PavelKrm on 27.02.24.
//

import UIKit
import SnapKit

final class DateView: UIView {
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .appYellow
        label.font = .appBoldFont.withSize(25.0)
        return label
    }()
    
    private lazy var monthLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .appBoldFont.withSize(15.0)
        return label
    }()
    
    var day: String? {
        get { dateLabel.text }
        set { dateLabel.text = newValue }
    }
    
    var month: String? {
        get { monthLabel.text }
        set { monthLabel.text = newValue }
    }
    
    init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setupUI()
        setupConstraints()
    }
    
    private func setupUI() {
        self.backgroundColor = .appBlack
        
        self.cornerRadius = 5.0
        
        addSubview(dateLabel)
        addSubview(monthLabel)
    }
    
    private func setupConstraints() {
        
        dateLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(4.0)
            make.height.equalTo(25.0)
        }
        
        monthLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom)
            make.centerX.equalTo(dateLabel.snp.centerX)
            make.bottom.equalToSuperview().inset(4.0)
        }
    }
}
