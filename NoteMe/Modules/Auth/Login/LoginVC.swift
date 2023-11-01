//
//  LoginVC.swift
//  NoteMe
//
//  Created by PavelKrm on 24.10.23.
//

import UIKit
import SnapKit

final class LoginVC: UIViewController {
    
    private lazy var contenView: UIView = {
        let view = UIView()
        view.backgroundColor = .appGray
        return view
    }()
    
    private lazy var logoImageView: UIImageView =
    UIImageView(image: .General.logo)
    
    private lazy var loginButton: UIButton = .yellowRoundedButton("Login")
    private lazy var signUpButton: UIButton = .underlineYellowButton("New Account")
    private lazy var forgotPasButton: UIButton = .underlineGrayButton("Forgot Password")
    
    private lazy var label: UILabel = .titleLabel("Welcome Back!")
    
    private lazy var signInView: UIView = {
        let view = UIView()
        view.cornerRadius = 5.0
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var emailTextField: LineTextField = {
        let textField = LineTextField()
        textField.title = "E-mail"
        textField.placeholder = "Enter E-mail"
        
        return textField
    }()
    
    private lazy var passwordTextField: LineTextField = {
        let textFIeld = LineTextField()
        textFIeld.title = "Password"
        textFIeld.placeholder = "Enter Password"
        
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
    }
    
    private func setupUI() {
        
        view.backgroundColor = .appBlack
        view.addSubview(contenView)
        view.addSubview(loginButton)
        view.addSubview(signUpButton)
        contenView.addSubview(logoImageView)
        contenView.addSubview(signInView)
        contenView.addSubview(label)
        signInView.addSubview(forgotPasButton)
        signInView.addSubview(emailTextField)
        signInView.addSubview(passwordTextField)
    }
    
    private func setupConstraints() {
        
        signUpButton.snp.makeConstraints { make in
            make.height.equalTo(20.0)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(-8.0)
        }
        
        loginButton.snp.makeConstraints { make in
            make.height.equalTo(45.0)
            make.horizontalEdges.equalToSuperview().inset(20.0)
            make.bottom.equalTo(signUpButton.snp.top).inset(-8.0)
        }
        
        contenView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(loginButton.snp.centerY)
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
        
        forgotPasButton.snp.makeConstraints { make in
            make.bottom.left.equalToSuperview().inset(16.0)
            make.height.equalTo(17.0)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.horizontalEdges.top.equalToSuperview().inset(16.0)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).inset(-16.0)
            make.horizontalEdges.equalToSuperview().inset(16.0)
            make.bottom.equalTo(forgotPasButton.snp.top).inset(-20.0)
        }
        
    }
}
