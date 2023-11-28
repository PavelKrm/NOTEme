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
    
    private lazy var nextButton: UIButton =
        .yellowRoundedButton("next".localized)
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
        
        view.backgroundColor = .appGray
        view.addSubview(nextButton)
        
    }
    
    private func setupConstraince() {
        
        nextButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(20.0)
            make.height.equalTo(45.0)
        }
    }
}
