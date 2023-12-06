//
//  ResetPasswordVC.swift
//  NoteMe
//
//  Created by PavelKrm on 1.11.23.
//

import UIKit
import SnapKit

@objc protocol ResetPasswordViewModelProtocol: AnyObject {
    
    var catchEmailError: ((String?) -> Void)? { get set }
    @objc func cancelDidTap()
    func resetPassDidTap(email: String?)
    func finish()
}

final class ResetPasswordVC: UIViewController {
    
    private lazy var contenView: UIView = .contentView()
    
    private lazy var logoContainer: UIView = UIView()
    
    private lazy var logoImageView: UIImageView =
    UIImageView(image: .General.logo)
    
    private lazy var resetButton: UIButton =
        .yellowRoundedButton("ResetPassVC_reset_btn".localized)
        .withAction(self, #selector(resetButtonDidTap))
    
    private lazy var cancelButton: UIButton = 
        .appCancelButton()
        .withAction(viewModel,
                    #selector(ResetPasswordViewModelProtocol.cancelDidTap))
    
    private lazy var titleLabel: UILabel = .titleLabel("ResetPassVC_reset_title_lbl".localized)
    private lazy var resetPasView: UIView = .signView()
    private lazy var resetInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "ResetPassVC_reset_password_title_textField".localized
        label.font = .appFont.withSize(13.0)
        label.numberOfLines = 2
        
        return label
    }()
    
    private lazy var emailTextField: LineTextField = {
        let textField = LineTextField()
        textField.placeholder = "ResetPassVC_reset_password_placeholder_textField".localized
        textField.keyboardType = UIKeyboardType.emailAddress
        textField.returnKeyType = UIReturnKeyType.done
        
        return textField
    }()
    
    private var viewModel: ResetPasswordViewModelProtocol
    
    init(viewModel: ResetPasswordViewModelProtocol) {
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
    }
    
    private func setupUI() {
        
        view.backgroundColor = .appBlack
        view.addSubview(contenView)
        view.addSubview(resetButton)
        view.addSubview(cancelButton)
        
        contenView.addSubview(logoContainer)
        contenView.addSubview(resetPasView)
        contenView.addSubview(titleLabel)
        
        logoContainer.addSubview(logoImageView)
        
        resetPasView.addSubview(emailTextField)
        resetPasView.addSubview(resetInfoLabel)
    }
    
    private func setupConstraints() {
        
        cancelButton.snp.makeConstraints { make in
            make.height.equalTo(45.0)
            make.horizontalEdges.equalToSuperview().inset(20.0)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(8.0)
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
        
        logoContainer.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(resetPasView.snp.top)
        }
        
        logoImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
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
    
    @objc private func resetButtonDidTap() {
        
        viewModel.resetPassDidTap(email: emailTextField.text)
    }
}
