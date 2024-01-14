//
//  SettingsButton.swift
//  NoteMe
//
//  Created by PavelKrm on 14.01.24.
//

import UIKit
import SnapKit

final class SettingsButton: UIView {
    
    private lazy var separator: UIView = {
        let view = UIView()
        view.backgroundColor = .appText
        return view
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.imageView?.contentMode = .scaleAspectFill
        button.titleLabel?.font = .appFont.withSize(14.0)
        button.contentHorizontalAlignment = .left
        return button
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = .appLightGrayText
        label.textAlignment = .right
        label.font = .appFont.withSize(12.0)
        return label
    }()
    
    var buttonTitle: String? {
        get { button.currentTitle }
        set { button.setTitle(newValue, for: .normal) }
    }
    
    var infoLabel: String? {
        get { label.text }
        set { label.text = newValue }
    }
    
    var buttonImage: UIImage? {
        get { button.currentImage }
        set { button.setImage(newValue, for: .normal) }
    }
    
    var buttonColor: UIColor {
        get { button.currentTitleColor }
        set { button.setTitleColor(newValue, for: .normal) }
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
        addSubview(button)
        addSubview(label)
        addSubview(separator)
    }
    
    private func setupConstraints() {
        
        button.snp.makeConstraints { make in
            make.top.left.equalToSuperview()
            make.right.equalTo(label.snp.left).inset(-8.0)
        }
        
        separator.snp.makeConstraints { make in
            make.top.equalTo(button.snp.bottom).inset(-12.0)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(1.0)
            make.bottom.equalToSuperview()
        }
        
        label.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.centerY.equalTo(button.snp.centerY)
            make.left.equalTo(button.snp.right).inset(8.0)
        }
    }
}
