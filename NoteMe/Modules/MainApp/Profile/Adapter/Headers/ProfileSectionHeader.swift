//
//  ProfileSectionHeader.swift
//  NoteMe
//
//  Created by PavelKrm on 26.01.24.
//

import UIKit
import SnapKit

final class ProfileSectionHeader: UIView {
    
    private lazy var view: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private var title: UILabel = {
        let label = UILabel()
        label.font = .appBoldFont.withSize(14.0)
        label.textColor = .appText
        return label
    }()
    
    var text: String? {
        get { title.text }
        set { title.text = newValue}
    }
    
    init() {
        super.init(frame: .zero)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        addSubview(view)
        view.addSubview(title)
    }
    
    private func setupConstraints() {
        
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        title.snp.makeConstraints { make in
            make.top.left.equalToSuperview()
            make.bottom.equalToSuperview().inset(16.0)
        }
    }
}
