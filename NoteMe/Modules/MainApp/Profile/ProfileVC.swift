//
//  ProfileVC.swift
//  NoteMe
//
//  Created by PavelKrm on 30.11.23.
//

import UIKit
import SnapKit

protocol ProfileViewModelProtocol {}

final class ProfileVC: UIViewController {
    
    private var viewModel: ProfileViewModelProtocol
    
    init(viewModel: ProfileViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        
        view.backgroundColor = .appBlack
    }
}
