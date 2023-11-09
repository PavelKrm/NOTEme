//
//  ResetPasswordVC.swift
//  NoteMe
//
//  Created by PavelKrm on 1.11.23.
//

import UIKit
import SnapKit

final class ResetPasswordVC: UIViewController {
    
    private lazy var contenView: UIView = .contentView()
    
    private lazy var logoImageView: UIImageView =
    UIImageView(image: .General.logo)
    
    private lazy var resetButton: UIButton =
        .yellowRoundedButton("reset_btn".localized)
    
    private lazy var cancelButton: UIButton = .appCancelButton()
    private lazy var titleLabel: UILabel = .titleLabel("reset_title_lbl".localized)
    private lazy var resetPasView: UIView = .signView()
    private lazy var resetInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "reset_password_title_textField".localized
        label.font = .appFont.withSize(13.0)
        label.numberOfLines = 2
        
        return label
    }()
    
    private lazy var emailTextField: LineTextField = {
        let textField = LineTextField()
        textField.placeholder = "reset_password_placeholder_textField".localized
        
        return textField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstraints()
    }
    
    private func setupUI() {
        
        view.backgroundColor = .appBlack
        view.addSubview(contenView)
        view.addSubview(resetButton)
        view.addSubview(cancelButton)
        contenView.addSubview(logoImageView)
        contenView.addSubview(resetPasView)
        contenView.addSubview(titleLabel)
        resetPasView.addSubview(emailTextField)
        resetPasView.addSubview(resetInfoLabel)
    }
    
    private func setupConstraints() {
        
        cancelButton.snp.makeConstraints { make in
            make.height.equalTo(45.0)
            make.horizontalEdges.equalToSuperview().inset(20.0)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(-8.0)
        }
        
        resetButton.snp.makeConstraints { make in
            make.height.equalTo(45.0)
            make.horizontalEdges.equalToSuperview().inset(20.0)
            make.bottom.equalTo(cancelButton.snp.top).inset(-8.0)
        }
        
        contenView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(resetButton.snp.centerY)
        }
        
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(72.0)
            make.centerX.equalToSuperview()
            make.size.equalTo(96.0)
        }
        
        resetPasView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16.0)
            make.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(resetPasView.snp.top).inset(-8.0)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(20.0)
            make.horizontalEdges.equalToSuperview().inset(16.0)
            make.top.equalTo(resetInfoLabel.snp.bottom).inset(-8)
        }
        
        resetInfoLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview().inset(16.0)
        }
    }
}
