//
//  AddNotificationVC.swift
//  NoteMe
//
//  Created by PavelKrm on 12.02.24.
//

import UIKit
import SnapKit

protocol AddNotificationViewModelProtocol {
    
    var typeNotification: AddNotification { get set }
    
    func createNotification(_ type: AddNotification,
                            title: String,
                            targetDate: Date?,
                            subTitle: String,
                            longitude: Double?,
                            latitude: Double?,
                            imagePath: String?)
    
    func createNotification()
    func cancelDidTap()
}

final class AddNotificationVC: UIViewController {
    
    private var titleStr: String {
        switch viewModel.typeNotification {
        case .calendar: return L10n.titleDate
        case .location: return L10n.titleLocation
        case .timer: return L10n.titleTimer
        }
    }
    private lazy var backgroundView: UIView = .backgroundView()
    private lazy var contenView: UIView = .contentView()
    private lazy var titleLbl: UILabel = .secondaryTitleLabel(titleStr)
    private lazy var subtitleLbl: UILabel = .infoLabel(L10n.subtitleTV,
                                                       with: 13.0,
                                                       font: .appBoldFont)
    
    private lazy var titleTextField: LineTextField = {
        let tf = LineTextField()
        tf.title = L10n.titleTF
        tf.placeholder = L10n.titlePH
        return tf
    }()
    
    private lazy var subtitleTextView: UITextView = {
        let tv = UITextView()
        tv.isScrollEnabled = false
        tv.setBorder(width: 1.0, color: .appBlack)
        return tv
    }()
    
    private lazy var dateTextField: LineTextField = {
        let tf = LineTextField()
        tf.title = L10n.dateTF
        tf.placeholder = L10n.datePH
        return tf
    }()
    
    private lazy var timerTextField: LineTextField = {
        let tf = LineTextField()
        tf.title = L10n.timerTF
        tf.placeholder = L10n.timerPH
        return tf
    }()
    
    private lazy var createBatton: UIButton =
        .yellowRoundedButton(L10n.create)
        .withAction(self, #selector(createDidTap))
    
    private lazy var cancelButton: UIButton =
        .appCancelButton()
        .withAction(self, #selector(cancelDidTap))
    
    private var viewModel: AddNotificationViewModelProtocol
    
    init(viewModel: AddNotificationViewModelProtocol) {
        self.viewModel = viewModel
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
    
    @objc private func createDidTap() {
        
    }
    
    @objc func cancelDidTap() {}
    
    private func setupUI() {
        
        view.backgroundColor = .appBlack
        view.addSubview(backgroundView)
        view.addSubview(createBatton)
        view.addSubview(cancelButton)
        
        backgroundView.addSubview(contenView)
        backgroundView.addSubview(titleLbl)
        
        contenView.addSubview(titleTextField)
        contenView.addSubview(subtitleTextView)
        
//        switch viewModel.typeNotification {
        /*case .calendar:*/ contenView.addSubview(dateTextField)
        /*case .location:*/ contenView.addSubview(dateTextField)
        /*case .timer:*/ contenView.addSubview(timerTextField)
//        }
    }
    
    private func setupConstraints() {
        
        cancelButton.snp.makeConstraints { make in
            make.height.equalTo(20.0)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(8.0)
        }
        
        createBatton.snp.makeConstraints { make in
            make.height.equalTo(45.0)
            make.horizontalEdges.equalToSuperview().inset(20.0)
            make.bottom.equalTo(cancelButton.snp.top).inset(-8.0)
        }
        
        backgroundView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(createBatton.snp.centerY)
        }
        
        titleLbl.snp.makeConstraints { make in
            make.top.left.equalTo(20.0)
        }
        
        contenView.snp.makeConstraints { make in
            make.top.equalTo(titleLbl.snp.bottom).inset(10.0)
            make.edges.equalToSuperview().inset(20.0)
        }
        
        titleTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16.0)
        }
        
        dateTextField.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).inset(16.0)
            make.edges.equalToSuperview().inset(16.0)
            
            if viewModel.typeNotification != .calendar {
                make.height.equalTo(0.0)
            }
        }
        
        timerTextField.snp.makeConstraints { make in
            make.top.equalTo(dateTextField.snp.bottom).inset(16.0)
            make.edges.equalToSuperview().inset(16.0)
            
            if viewModel.typeNotification != .timer {
                make.height.equalTo(0.0)
            }
        }
        
        subtitleLbl.snp.makeConstraints { make in
            make.top.equalTo(timerTextField.snp.bottom).inset(16.0)
            make.left.equalToSuperview().inset(16.0)
        }
        
        subtitleTextView.snp.makeConstraints { make in
            make.top.equalTo(subtitleLbl.snp.bottom).inset(4.0)
            make.bottom.edges.equalToSuperview().inset(16.0)
            make.height.equalTo(68.0)
        }
    }
}

//MARK: - L10n

extension AddNotificationVC {
    private enum L10n {
        static var titleLocation = "AddNotificationVC_Location_title".localized
        static var titleDate = "AddNotificationVC_Date_title".localized
        static var titleTimer = "AddNotificationVC_Timer_title".localized
        static var titleTF = "AddNotificationVC_titleTF_title".localized
        static var titlePH = "AddNotificationVC_titlePH_placeholder".localized
        static var subtitleTV = "AddNotificationVC_subtitleTV_title".localized
        static var subtitlePH = "AddNotificationVC_subtitlePH_placeholder".localized
        static var timerTF = "AddNotificationVC_timerTF_title".localized
        static var timerPH = "AddNotificationVC_timerPH_placeholder".localized
        static var dateTF = "AddNotificationVC_dateTF_title".localized
        static var datePH = "AddNotificationVC_datePH_placeholder".localized
        static var create = "AddNotificationVC_createBtn_title".localized
        static var cancel = "AddNotificationVC_cancelBtn_title".localized
    }
}
