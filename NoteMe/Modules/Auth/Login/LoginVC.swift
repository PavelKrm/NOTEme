//
//  LoginVC.swift
//  NoteMe
//
//  Created by PavelKrm on 24.10.23.
//

import UIKit
import SnapKit

@objc protocol LoginViewModelProtocol: AnyObject {
    
    var catchEmailError: ((String?) -> Void)? { get set }
    var catchPassError: ((String?) -> Void)? { get set }
    
    func loginDidTap(email: String?, pass: String?)
    @objc func newAccountDidTap()
    func forgotPassDidTap(email: String?)
    func keyboardFrameChanged(completion: @escaping (CGRect) -> Void)
}

final class LoginVC: UIViewController {
    
    private lazy var contenView: UIView = .contentView()
    
    private lazy var logoContainer: UIView = UIView()
    
    private lazy var logoImageView: UIImageView =
    UIImageView(image: .General.logo)
    
    private lazy var loginButton: UIButton =
        .yellowRoundedButton("LoginVC_login_btn".localized)
        .withAction(self, #selector(loginDidTap))
    
    private lazy var signUpButton: UIButton = 
        .underlineYellowButton("LoginVC_signup_btn".localized)
        .withAction(viewModel,
                    #selector(LoginViewModelProtocol.newAccountDidTap))
    
    private lazy var forgotPasButton: UIButton = 
        .underlineGrayButton("LoginVC_forgot_btn".localized)
        .withAction(self, #selector(forgotPassDidTap))
    
    private lazy var titleLabel: UILabel =
        .titleLabel("LoginVC_welcome_title_lbl".localized)
    
    private lazy var signInView: UIView = .signView()
    
    private lazy var emailTextField: LineTextField = {
        let textField = LineTextField()
        textField.title = "LoginVC_email_title_textField".localized
        textField.placeholder = "LoginVC_email_placeholder_textField".localized
        
        return textField
    }()
    
    private lazy var passwordTextField: LineTextField = {
        let textFIeld = LineTextField()
        textFIeld.title = "LoginVC_password_title_textField".localized
        textFIeld.placeholder = "LoginVC_password_placeholder_textField".localized
        
        return textFIeld
    }()
    
    private var viewModel: LoginViewModelProtocol
    
    init(viewModel: LoginViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstraints()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    private func bind() {
        viewModel.catchEmailError = { errorText in
            self.emailTextField.errorText = errorText
        }
        
        viewModel.catchPassError = {
            self.passwordTextField.errorText = $0
        }
        
        viewModel.keyboardFrameChanged { frame in
            
            let maxY = self.signInView.frame.maxY + 36.0
            let keyboardY = frame.minY
            if maxY > keyboardY {
                
                let diff = maxY - keyboardY
                UIView.animate(withDuration: 0.25) {
                    self.signInView.snp.updateConstraints { make in
                        make.centerY.equalToSuperview().offset(-diff)
                    }
                    self.view.layoutIfNeeded()
                }
            } else if maxY < keyboardY {
                
                UIView.animate(withDuration: 0.25) {
                    self.signInView.snp.updateConstraints { make in
                        make.centerY.equalToSuperview()
                    }
                    self.view.layoutIfNeeded()
                }
            }
        }
    }
    
    private func setupUI() {
        
        view.backgroundColor = .appBlack
        view.addSubview(contenView)
        view.addSubview(loginButton)
        view.addSubview(signUpButton)
        
        contenView.addSubview(logoContainer)
        contenView.addSubview(signInView)
        contenView.addSubview(titleLabel)
        
        logoContainer.addSubview(logoImageView)
        
        signInView.addSubview(forgotPasButton)
        signInView.addSubview(emailTextField)
        signInView.addSubview(passwordTextField)
    }
    
    private func setupConstraints() {
        
        signUpButton.snp.makeConstraints { make in
            make.height.equalTo(20.0)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(8.0)
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
        
        logoContainer.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(signInView.snp.top)
        }
        
        logoImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(96.0)
        }
        
        signInView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16.0)
            make.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
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
    
    @objc private func loginDidTap() {
        viewModel.loginDidTap(email: emailTextField.text,
                              pass: passwordTextField.text)
    }
    
    @objc private func forgotPassDidTap() {
        viewModel.forgotPassDidTap(email: emailTextField.text)
    }
}
