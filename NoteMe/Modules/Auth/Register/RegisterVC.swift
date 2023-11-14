//
//  RegisterVC.swift
//  NoteMe
//
//  Created by PavelKrm on 1.11.23.
//

import UIKit
import SnapKit

@objc protocol RegisterPresentorProtocol: AnyObject {
    
    func registerDidTap(email: String?, pass: String?, repeat: String?)
    @objc optional func haveAnAccountDidTap()
}

final class RegisterVC: UIViewController {
    
    private lazy var contenView: UIView = .contentView()
    
    private lazy var logoContainer: UIView = UIView()
    private lazy var logoImageView: UIImageView =
    UIImageView(image: .General.logo)
    
    private lazy var registerButton: UIButton =
        .yellowRoundedButton("register_btn".localized)
        .withAction(self, #selector(registerDidTap))
    
    private lazy var haveAnAccountButton: UIButton =
        .underlineYellowButton("have_an_acc_btn".localized)
        .withAction(presenter,
                    #selector(RegisterPresentorProtocol.haveAnAccountDidTap))
    
    private lazy var titleLabel: UILabel =
        .titleLabel("nice_to_meet_title_lbl".localized)
    
    private lazy var signInView: UIView = .signView()
    
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
    
    private var presenter: RegisterPresentorProtocol
    
    init(presenter: RegisterPresentorProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
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
    
    private func setupUI() {
        
        view.backgroundColor = .appBlack
        view.addSubview(contenView)
        view.addSubview(registerButton)
        view.addSubview(haveAnAccountButton)
        contenView.addSubview(logoContainer)
  
        contenView.addSubview(signInView)
        contenView.addSubview(titleLabel)
        
        logoContainer.addSubview(logoImageView)
        signInView.addSubview(emailTextField)
        signInView.addSubview(passwordTextField)
        signInView.addSubview(repeatPassTextField)
    }
    
    private func setupConstraints() {
        
        haveAnAccountButton.snp.makeConstraints { make in
            make.height.equalTo(20.0)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(8.0)
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
    
    @objc private func registerDidTap() {
        presenter.registerDidTap(email: emailTextField.text,
                                 pass: passwordTextField.text,
                                 repeat: repeatPassTextField.text)
    }
}

extension RegisterVC: RegisterPresentorDelegate {
    
    func keyboardFrameChanged(_ frame: CGRect) {

        let maxY = signInView.frame.maxY + 16.0
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
    
    func setEmailError(error: String?) {
        emailTextField.errorText = error
    }
    
    func setPasswordError(error: String?) {
        passwordTextField.errorText = error
    }
    
    func setRepeatPasswordError(error: String?) {
        repeatPassTextField.errorText = error
    }
}
