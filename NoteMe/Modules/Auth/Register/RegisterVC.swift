//
//  RegisterVC.swift
//  NoteMe
//
//  Created by PavelKrm on 1.11.23.
//

import UIKit
import SnapKit

final class RegisterVC: UIViewController {
    
    private lazy var contenView: UIView = {
        let view = UIView()
        view.backgroundColor = .appGray
        return view
    }()
    
    private lazy var logoImageView: UIImageView =
    UIImageView(image: .General.logo)
    
    private lazy var registerButton: UIButton = .yellowRoundedButton("register_btn".localized)
    private lazy var haveAnAccountButton: UIButton = .underlineYellowButton("have_an_acc_btn".localized)
    
    private lazy var label: UILabel = .titleLabel("nice_to_meet_title_lbl".localized)
    
    private lazy var signInView: UIView = {
        let view = UIView()
        view.cornerRadius = 5.0
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var emailTextField: LineTextField = {
        let textField = LineTextField()
        textField.title = "email_title_textField".localized
        textField.placeholder = "email_placeholder_textField".localized
        
        return textField
    }()
    
    private lazy var passwordTextField: LineTextField = {
        let textFIeld = LineTextField()
        textFIeld.title = "password_title_textField".localized
        textFIeld.placeholder = "password_placeholder_textField".localized
        
        return textFIeld
    }()
    
    private lazy var repeatPassTextField: LineTextField = {
        let textFIeld = LineTextField()
        textFIeld.title = "repeat_password_title_textField".localized
        textFIeld.placeholder = "repeat_password_placeholder_textField".localized
        
        return textFIeld
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstraints()
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
//            self.emailTextField.errorText = "Error text after 3 sec"
//        }
//        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 6.0) {
//            self.passwordTextField.errorText = "Error text after 6 sec"
//        }
//        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 9.0) {
//            self.repeatPassTextField.errorText = "Error text after 9 sec"
//        }
        
    }
    
    private func setupUI() {
        
        view.backgroundColor = .appBlack
        view.addSubview(contenView)
        view.addSubview(registerButton)
        view.addSubview(haveAnAccountButton)
        contenView.addSubview(logoImageView)
        contenView.addSubview(signInView)
        contenView.addSubview(label)
        signInView.addSubview(emailTextField)
        signInView.addSubview(passwordTextField)
        signInView.addSubview(repeatPassTextField)
        
    }
    
    private func setupConstraints() {
        
        haveAnAccountButton.snp.makeConstraints { make in
            make.height.equalTo(20.0)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(-8.0)
        }
        
        registerButton.snp.makeConstraints { make in
            make.height.equalTo(45.0)
            make.horizontalEdges.equalToSuperview().inset(20.0)
            make.bottom.equalTo(haveAnAccountButton.snp.top).inset(-8.0)
        }
        
        contenView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(registerButton.snp.centerY)
        }
        
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(72.0)
            make.centerX.equalToSuperview()
            make.size.equalTo(96.0)
        }
        
        signInView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16.0)
            make.centerY.equalToSuperview()
        }
        
        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(signInView.snp.top).inset(-8.0)
        }
        
        repeatPassTextField.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(20.0)
            make.horizontalEdges.equalToSuperview().inset(16.0)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.horizontalEdges.top.equalToSuperview().inset(16.0)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).inset(-16.0)
            make.horizontalEdges.equalToSuperview().inset(16.0)
            make.bottom.equalTo(repeatPassTextField.snp.top).inset(-16.0)
        }
        
    }
}
