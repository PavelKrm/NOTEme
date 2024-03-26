//
//  AddLocationNotificationVC.swift
//  NoteMe
//
//  Created by PavelKrm on 27.02.24.
//

import UIKit
import SnapKit

protocol AddLocationNotificationViewModelProtocol {
    
    var updatePreview: ((UIImage?) -> Void)? { get set }
    
    var title: String? { get set }
    var subtitle: String? { get set }
    
    func openMapView()
    func createNotification()
    func cancelDidTap()
}

final class AddLocationNotificationVC: UIViewController {
    
    private lazy var backgroundView: UIView = .backgroundView()
    private lazy var contentView: UIView = .contentView()
    private lazy var titleLbl: UILabel = .secondaryTitleLabel(L10n.titleLocation)
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
    
    private var titlePreview: UILabel = .infoLabel(L10n.titlePreview,
                                                   with: 13.0,
                                                   font: .appBoldFont)
    
    private lazy var mapButton: UIButton =
        .mapButton()
        .withAction(self, #selector(mapButtonDidTap))
    
    private lazy var createBatton: UIButton =
        .yellowRoundedButton(L10n.create)
        .withAction(self, #selector(createDidTap))
    
    private lazy var cancelButton: UIButton =
        .appCancelButton()
        .withAction(self, #selector(cancelDidTap))
    
    private var viewModel: AddLocationNotificationViewModelProtocol
    
    init(viewModel: AddLocationNotificationViewModelProtocol) {
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
        configure()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    private func bind() {
        
        viewModel.updatePreview = { [weak self] image in
            self?.mapButton.setBackgroundImage(image, for: .normal)
        }
    }
    
    private func configure() {
        titleTextField.text = viewModel.title
        subtitleTextView.text = viewModel.subtitle
    }
    
    @objc private func mapButtonDidTap() {
        viewModel.openMapView()
        print(#function)
    }
    
    @objc private func createDidTap() {
        viewModel.createNotification()
    }
    
    @objc private func cancelDidTap() {
        viewModel.cancelDidTap()
    }
    
    private func setupUI() {
        
        view.backgroundColor = .appBlack
        view.addSubview(backgroundView)
        view.addSubview(createBatton)
        view.addSubview(cancelButton)
        
        backgroundView.addSubview(titleLbl)
        backgroundView.addSubview(contentView)
        
        contentView.addSubview(titleTextField)
        contentView.addSubview(subtitleLbl)
        contentView.addSubview(subtitleTextView)
        contentView.addSubview(titlePreview)
        contentView.addSubview(mapButton)

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
        
        subtitleLbl.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).inset(-16.0)
            make.left.equalToSuperview().inset(16.0)
        }
        
        subtitleTextView.snp.makeConstraints { make in
            make.top.equalTo(subtitleLbl.snp.bottom).inset(-4.0)
            make.horizontalEdges.equalToSuperview().inset(16.0)
            make.height.equalTo(68.0)
        }
        
        titlePreview.snp.makeConstraints { make in
            make.top.equalTo(subtitleTextView.snp.bottom).inset(-16.0)
            make.left.equalToSuperview().inset(16.0)
        }
        
        mapButton.snp.makeConstraints { make in
            make.top.equalTo(titlePreview.snp.bottom).inset(-8.0)
            make.bottom.horizontalEdges.equalToSuperview().inset(16.0)
            make.height.equalTo(147.0)
        }
    }
}

//MARK: - UITextViewDelegete

extension AddLocationNotificationVC: UITextViewDelegate {
    
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

//MARK: - UITextFieldDelegete

extension AddLocationNotificationVC: LineTextFieldDelegate {
    
    func textFieldDidEndEditing(_ lineTextField: LineTextField) {
        if lineTextField == titleTextField {
            viewModel.title = lineTextField.text
        }
    }
}

//MARK: - L10n

extension AddLocationNotificationVC {
    private enum L10n {
        
        static var titleLocation = "AddNotificationVC_Location_title".localized
        static var titleTF = "AddNotificationVC_titleTF_title".localized
        static var titlePH = "AddNotificationVC_titlePH_placeholder".localized
        static var subtitleTV = "AddNotificationVC_subtitleTV_title".localized
        static var subtitlePH = "AddNotificationVC_subtitlePH_placeholder".localized
        static var create = "AddNotificationVC_createBtn_title".localized
        static var cancel = "AddNotificationVC_cancelBtn_title".localized
        static var titlePreview = "AddNotificationVC_preview_title".localized
    }
}
