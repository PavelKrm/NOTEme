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
    
    private lazy var doneButton: UIButton =
        .yellowRoundedButton("done".localized)
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
        
        view.backgroundColor = .appGray
        view.addSubview(doneButton)
    }
    
    private func setupConstraince() {
        
        doneButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(20.0)
            make.height.equalTo(45.0)
        }
    }
}
