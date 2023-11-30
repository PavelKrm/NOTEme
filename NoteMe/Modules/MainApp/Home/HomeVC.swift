//
//  HomeVC.swift
//  NoteMe
//
//  Created by PavelKrm on 29.11.23.
//

import UIKit
import SnapKit

protocol HomeViewModelProtocol {
    
}

final class HomeVC: UIViewController {
    
    private var viewModel: HomeViewModelProtocol
    
    init(viewModel: HomeViewModelProtocol) {
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
        
        view.backgroundColor = .appYellow
    }
}
