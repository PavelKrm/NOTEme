//
//  AddTimerNotificationVC.swift
//  NoteMe
//
//  Created by PavelKrm on 27.02.24.
//

import UIKit
import SnapKit

protocol AddTimerNotificationViewModelProtocol {
    
    var timeLeft: Int? { get set }
    var cachTime: ((String) -> Void)? { get set }
    var subtitle: String? { get set }
    
    func createNotification(title: String?)
    func cancelDidTap()
}

final class AddTimerNotificationVC: UIViewController {

    private lazy var backgroundView: UIView = .backgroundView()
    private lazy var contentView: UIView = .contentView()
    private lazy var titleLbl: UILabel = .secondaryTitleLabel(L10n.titleTimer)
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
        tv.text = L10n.subtitlePH
        tv.textColor = .appGrayText
        tv.tintColor = .appGrayText
        tv.font = .appFont.withSize(15.0)
        tv.setBorder(width: 1.0, color: .appBlack)
        tv.backgroundColor = .white
        tv.delegate = self
        return tv
    }()
    
    private lazy var timerTextField: LineTextField = {
        let tf = LineTextField()
        tf.title = L10n.timerTF
        tf.placeholder = L10n.timerPH
        tf.picker = timePicker
        tf.accessoryView = toolBar
        return tf
    }()
    
    private lazy var toolBar: UIToolbar = {
        let toolBar = UIToolbar(frame: CGRect(origin: CGPoint.zero,
                                              size: CGSize(
                                                width: self.view.frame.width,
                                                height: CGFloat(45.0)
                                                            )))
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.backgroundColor = .appBlack
        toolBar.barTintColor = .appBlack
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                    target: nil,
                                    action: nil)
        space.tintColor = .appBlack
        
        let doneButton = UIBarButtonItem(title: "Done",
                                         style: .plain,
                                         target: self,
                                         action: #selector(pickerDoneButton))
        doneButton.tintColor = .appYellow
        
        let cancelButton = UIBarButtonItem(title: "Cancel",
                                           style: .plain,
                                           target: self,
                                           action: #selector(pickerCancelButton))
        cancelButton.tintColor = .appYellow
                
        toolBar.setItems([cancelButton, space, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        
        return toolBar
    }()
    
    private lazy var timePicker: UIDatePicker =
        .appDatePicker(mode: .countDownTimer,
                       target: self,
                       action:  #selector(pickerDateSelected))
    
    private lazy var createBatton: UIButton =
        .yellowRoundedButton(L10n.create)
        .withAction(self, #selector(createDidTap))
    
    private lazy var cancelButton: UIButton =
        .appCancelButton()
        .withAction(self, #selector(cancelDidTap))
    
    private var viewModel: AddTimerNotificationViewModelProtocol
    
    init(viewModel: AddTimerNotificationViewModelProtocol) {
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
        
        viewModel.cachTime = { [weak self] text in
            self?.timerTextField.text = text
        }
        
    }
    
    @objc private func createDidTap() {
        
        viewModel.createNotification(title: titleTextField.text)
    }
    
    @objc func cancelDidTap() {
        viewModel.cancelDidTap()
    }
    
    @objc func pickerDateSelected(sender: UIDatePicker) {
        
        let seconds = sender.countDownDuration
        viewModel.timeLeft = Int(seconds)
    }
    
    @objc func pickerDoneButton() {
        pickerCancelButton()
    }
    
    @objc func pickerCancelButton() {
        timerTextField.endEditing(false)
    }
    
    private func setupUI() {
        
        view.backgroundColor = .appBlack
        view.addSubview(backgroundView)
        view.addSubview(createBatton)
        view.addSubview(cancelButton)
        
        backgroundView.addSubview(titleLbl)
        backgroundView.addSubview(contentView)
        
        contentView.addSubview(titleTextField)
        contentView.addSubview(timerTextField)
        contentView.addSubview(subtitleLbl)
        contentView.addSubview(subtitleTextView)
    }
    
    private func setupConstraints() {
        
        cancelButton.snp.makeConstraints { make in
            make.height.equalTo(45.0)
            make.horizontalEdges.equalToSuperview().inset(20.0)
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
            make.top.left.equalToSuperview().inset(20.0)
        }
        
        contentView.snp.makeConstraints { make in
            make.top.equalTo(titleLbl.snp.bottom).inset(-10.0)
            make.horizontalEdges.equalToSuperview().inset(20.0)
        }
        
        titleTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16.0)
            make.horizontalEdges.equalToSuperview().inset(16.0)
        }
        
        timerTextField.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).inset(-16.0)
            make.horizontalEdges.equalToSuperview().inset(16.0)
            
        }
        
        subtitleLbl.snp.makeConstraints { make in
            make.top.equalTo(timerTextField.snp.bottom).inset(-16.0)
            make.left.equalToSuperview().inset(16.0)
        }
        
        subtitleTextView.snp.makeConstraints { make in
            make.top.equalTo(subtitleLbl.snp.bottom).inset(-4.0)
            make.bottom.horizontalEdges.equalToSuperview().inset(16.0)
            make.height.equalTo(68.0)
        }
    }
}

//MARK: - UITextViewDelegete

extension AddTimerNotificationVC: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .appGrayText {
            textView.text = nil
            textView.textColor = .appText
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = L10n.subtitlePH
            textView.textColor = .appGrayText
        } else {
            viewModel.subtitle = textView.text
        }
    }
}

//MARK: - L10n

extension AddTimerNotificationVC {
    private enum L10n {
    

        static var titleTimer = "AddNotificationVC_Timer_title".localized
        static var titleTF = "AddNotificationVC_titleTF_title".localized
        static var titlePH = "AddNotificationVC_titlePH_placeholder".localized
        static var subtitleTV = "AddNotificationVC_subtitleTV_title".localized
        static var subtitlePH = "AddNotificationVC_subtitlePH_placeholder".localized
        static var timerTF = "AddNotificationVC_timerTF_title".localized
        static var timerPH = "AddNotificationVC_timerPH_placeholder".localized
        static var create = "AddNotificationVC_createBtn_title".localized
        static var cancel = "AddNotificationVC_cancelBtn_title".localized
    }
}
