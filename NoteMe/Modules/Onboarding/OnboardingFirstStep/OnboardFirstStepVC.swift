//
//  OnboardFirstStepVC.swift
//  NoteMe
//
//  Created by PavelKrm on 28.11.23.
//

import UIKit
import SnapKit

@objc protocol OnboardFirstStepViewModelProtocol {
    
    @objc func nextDidTap()
}

final class OnboardFirstStepVC: UIViewController {
    
    private lazy var contentView: UIView = .backgroundView()
    
    private lazy var logoContainer: UIView = UIView()
    
    private lazy var logoImageView: UIImageView =
        UIImageView(image: .General.logo)
    
    private lazy var titleLabel: UILabel =
        .titleLabel(L10n.titleLbl)
    
    private lazy var infoView: UIView = .contentView()
    
    private lazy var textLabel: UILabel =
        .infoLabel(L10n.textLblTitle,
                   with: 13.0)
    
    private lazy var nextButton: UIButton =
        .yellowRoundedButton(L10n.nextBtn)
        .withAction(viewModel, #selector(OnboardFirstStepViewModelProtocol.nextDidTap))
    
    private var viewModel: OnboardFirstStepViewModelProtocol
    
    init(viewModel: OnboardFirstStepViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstraince()
    }
    
    private func setupUI() {
        
        navigationController?.navigationBar.backgroundColor = .appGray
        
        view.backgroundColor = .appBlack
        view.addSubview(contentView)
        view.addSubview(nextButton)
        
        contentView.addSubview(logoContainer)
        contentView.addSubview(titleLabel)
        contentView.addSubview(infoView)
        
        logoContainer.addSubview(logoImageView)
        
        infoView.addSubview(textLabel)
        
    }
    
    private func setupConstraince() {
        
        nextButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20.0)
            make.height.equalTo(45.0)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(8.0)
        }
        
        contentView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(nextButton.snp.centerY)
        }
        
        infoView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16.0)
            make.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(infoView.snp.top).inset(-8.0)
        }
        
        logoContainer.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(titleLabel.snp.top)
        }
        
        logoImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(96.0)
        }
        
        textLabel.snp.makeConstraints { make in
            make.top.bottom.horizontalEdges.equalToSuperview().inset(16.0)
        }
    }
}

//MARK: - L10n

extension OnboardFirstStepVC {
    private enum L10n {
        static var titleLbl = "OnboardFirstStepVC_titleLabel_title".localized
        static var textLblTitle = "OnboardFirstStepVC_textLabel_title".localized
        static var nextBtn = "OnboardFirstStepVC_nextButton_title".localized
    }
}
