//
//  OnboardSecondStepVC.swift
//  NoteMe
//
//  Created by PavelKrm on 28.11.23.
//

import UIKit
import SnapKit

@objc protocol OnboardSecondStepViewModelProtocol {
    @objc func finish()
    func dismissedByUser()
}

final class OnboardSecondStepVC: UIViewController {
    
    private lazy var contentView: UIView = .contentView()
    
    private lazy var logoContainer: UIView = UIView()
    
    private lazy var logoImageView: UIImageView =
        UIImageView(image: .General.logo)
    
    private lazy var titleLabel: UILabel =
        .titleLabel("OnboardSecondStepVC_titleLabel_title".localized)
    
    private lazy var infoView: UIView = .signView()
    
    private lazy var infoImageContainer: UIView = UIView()
    
    private lazy var imageContainer: UIView = UIView()
    
    private lazy var infoImageView: UIImageView =
        UIImageView(image: .General.onboardInfoImage)
    
    private lazy var calendarItemLabel: UILabel =
        .infoLabel("OnboardSecondStepVC_calendarItemLabel_title".localized,
                   with: 16.0)
    private lazy var locationItemLabel: UILabel =
        .infoLabel("OnboardSecondStepVC_locationItemLabel_title".localized,
                   with: 16.0)
    private lazy var timerItemLabel: UILabel =
        .infoLabel("OnboardSecondStepVC_timerItemLabel_title".localized,
                   with: 16.0)
    
    private lazy var infoTextLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = .zero
        label.attributedText = .parse(html: "OnboardSecondStepVC_infoTextLabel_htmlTitle".localized,
                                      font: .appFont.withSize(13.0))
        return label
    }()
    
    private lazy var doneButton: UIButton =
        .yellowRoundedButton("OnboardSecondStepVC_doneBtn_title".localized)
        .withAction(viewModel, #selector(OnboardSecondStepViewModelProtocol.finish))
    
    private var viewModel: OnboardSecondStepViewModelProtocol
    
    init(viewModel: OnboardSecondStepViewModelProtocol) {
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
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        viewModel.dismissedByUser()
    }
    
    private func setupUI() {
        
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .appBlack
        view.addSubview(contentView)
        view.addSubview(doneButton)
        
        
        contentView.addSubview(logoContainer)
        contentView.addSubview(titleLabel)
        contentView.addSubview(infoView)
        contentView.addSubview(infoImageContainer)
        
        logoContainer.addSubview(logoImageView)
        
        infoView.addSubview(infoTextLabel)
        
        infoImageContainer.addSubview(imageContainer)
        imageContainer.addSubview(infoImageView)
        imageContainer.addSubview(calendarItemLabel)
        imageContainer.addSubview(locationItemLabel)
        imageContainer.addSubview(timerItemLabel)
        
    }
    
    private func setupConstraince() {
        
        doneButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20.0)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(8.0)
            make.height.equalTo(45.0)
        }
        
        contentView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(doneButton.snp.centerY)
        }
        
        infoView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16.0)
            make.centerY.equalToSuperview()
        }
        
        infoTextLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview().inset(16.0)
            make.bottom.equalTo(infoView.snp.bottom).inset(16.0)
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
        
        infoImageContainer.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalToSuperview()
            make.top.equalTo(infoView.snp.bottom)
        }
     
        imageContainer.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        infoImageView.snp.makeConstraints { make in
            make.height.equalTo(170)
            make.width.equalTo(212)
            make.center.equalToSuperview()
        }
        
        calendarItemLabel.snp.makeConstraints { make in
            make.left.equalTo(infoImageView.snp.left).inset(32.0)
            make.top.equalTo(infoImageView.snp.top).inset(22)
            make.height.equalTo(24.0)
        }
        
        locationItemLabel.snp.makeConstraints { make in
            make.top.equalTo(calendarItemLabel.snp.bottom).inset(-16.0)
            make.left.equalTo(infoImageView.snp.left).inset(32.0)
            make.height.equalTo(24.0)
        }
        
        timerItemLabel.snp.makeConstraints { make in
            make.top.equalTo(locationItemLabel.snp.bottom).inset(-16.0)
            make.left.equalTo(infoImageView.snp.left).inset(32.0)
            make.height.equalTo(24.0)
        }
    }
}
