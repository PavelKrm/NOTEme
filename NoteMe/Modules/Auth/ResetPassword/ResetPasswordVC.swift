//
//  ResetPasswordVC.swift
//  NoteMe
//
//  Created by PavelKrm on 1.11.23.
//

import UIKit
import SnapKit

final class ResetPasswordVC: UIViewController {
    
    private lazy var contenView: UIView = {
        let view = UIView()
        view.backgroundColor = .appGray
        return view
    }()
    
    private lazy var logoImageView: UIImageView =
    UIImageView(image: .General.logo)
    
    private lazy var resetButton: UIButton =
        .yellowRoundedButton("reset_btn".localized)
    
    private lazy var cancelButton: UIButton = .appCancelButton()
    private lazy var label: UILabel = .titleLabel("reset_title_lbl".localized)
    private lazy var resetPasView: UIView = .signView()
    private lazy var emailTextField: LineTextField = {
        let textField = LineTextField()
        textField.title = "reset_password_title_textField".localized
        textField.placeholder = "reset_password_placeholder_textField".localized
        
        return textField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstraints()
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
//            self.emailTextField.errorText = "Error text after 3 sec"
//        }
    }
    
    private func setupUI() {
        
        view.backgroundColor = .appBlack
        view.addSubview(contenView)
        view.addSubview(resetButton)
        view.addSubview(cancelButton)
        contenView.addSubview(logoImageView)
        contenView.addSubview(resetPasView)
        contenView.addSubview(label)
        resetPasView.addSubview(emailTextField)
  
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
        
        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(resetPasView.snp.top).inset(-8.0)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(20.0)
            make.horizontalEdges.top.equalToSuperview().inset(16.0)
        }
        
    }
}
