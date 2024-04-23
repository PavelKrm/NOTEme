//
//  MenuVC.swift
//  NoteMe
//
//  Created by PavelKrm on 11.02.24.
//

import UIKit
import SnapKit

protocol MenuViewModelProtocol {
    
    func makeTableView() -> UITableView
    func dismissedByUser()
}

final class MenuVC: UIViewController {
    
    private lazy var tableView: UITableView = viewModel.makeTableView()
    
    private var viewModel: MenuViewModelProtocol
    
    init(viewModel: MenuViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.addObserver(self,
                                   forKeyPath: "contentSize",
                                   options: .new,
                                   context: nil)
        
        setupUI()
        setupConstraints()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        tableView.removeObserver(self, forKeyPath: "contentSize")
        viewModel.dismissedByUser()
    }
    
    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?) {
        self.preferredContentSize = CGSize(width: 180.0,
                                           height: tableView.contentSize.height - 0.5)

    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        
        tableView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.verticalEdges.equalTo(
                self.view.safeAreaLayoutGuide.snp.verticalEdges
            )
        }
    }
}


extension UIViewController: UIPopoverPresentationControllerDelegate {
    
    public func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}
