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
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .appYellow
        let title = "Login"
        let attr = [NSAttributedString.Key.font: UIFont.appBoldFont,
                    NSAttributedString.Key.foregroundColor: UIColor.black]
        let attrTitle = NSAttributedString(string: title, attributes: attr)
        button.setAttributedTitle(attrTitle, for: .normal)
        button.layer.cornerRadius = 5.0
        return button
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton()
        let title = "New Account"
        let attr = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
                    NSAttributedString.Key.foregroundColor: UIColor.appYellow]
        let attrTitle = NSAttributedString(string: title, attributes: attr)
        button.setAttributedTitle(attrTitle, for: .normal)
        return button
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Welcome back!"
        label.font = UIFont.appBoldFont.withSize(25.0)
        return label
    }()
    
    private lazy var signInView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var forgotPasButton: UIButton = {
        let button = UIButton()
        let title = "Forgot Password"
        let attr = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
                    NSAttributedString.Key.foregroundColor: UIColor.lightGray,
                    NSAttributedString.Key.font: UIFont.appFont.withSize(15.0)]
        let attrTitle = NSAttributedString(string: title, attributes: attr)
        button.setAttributedTitle(attrTitle, for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstraints()
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
        
    }
    
    private func setupConstraints() {
        
        signUpButton.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 108.0, height: 20.0))
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(-8.0)
        }
        
        loginButton.snp.makeConstraints { make in
            make.size.height.equalTo(45.0)
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
            make.size.height.equalTo(165.0)
            make.horizontalEdges.equalToSuperview().inset(16.0)
            make.centerY.equalToSuperview()
        }
        
        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(signInView.snp.top).inset(-8.0)
        }
        
        forgotPasButton.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(16.0)
            make.bottom.equalToSuperview().inset(16.0)
        }
        
    }
}
