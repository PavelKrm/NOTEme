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
    private lazy var titleLbl: UILabel = .titleLabel(titleStr)
    
    private lazy var titleTextField: LineTextField = {
        let tf = LineTextField()
        tf.title = L10n.titleTF
        tf.placeholder = L10n.titlePH
        return tf
    }()
    
    private lazy var subtitleTextField: LineTextField = {
        let tf = LineTextField()
        tf.title = L10n.subtitleTF
        tf.placeholder = L10n.subtitlePH
        return tf
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
    
    private lazy var cancelButton: UIButton =
        .appCancelButton()
    
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
    
    private func setupUI() {}
    private func setupConstraints() {}
    
}

//MARK: - L10n

extension AddNotificationVC {
    private enum L10n {
        static var titleLocation = "AddNotificationVC_Location_title".localized
        static var titleDate = "AddNotificationVC_Date_title".localized
        static var titleTimer = "AddNotificationVC_Timer_title".localized
        static var titleTF = "AddNotificationVC_titleTF_title".localized
        static var titlePH = "AddNotificationVC_titlePH_placeholder".localized
        static var subtitleTF = "AddNotificationVC_subtitleTF_title".localized
        static var subtitlePH = "AddNotificationVC_subtitlePH_placeholder".localized
        static var timerTF = "AddNotificationVC_timerTF_title".localized
        static var timerPH = "AddNotificationVC_timerPH_placeholder".localized
        static var dateTF = "AddNotificationVC_dateTF_title".localized
        static var datePH = "AddNotificationVC_datePH_placeholder".localized
        static var create = "AddNotificationVC_createBtn_title".localized
        static var cancel = "AddNotificationVC_cancelBtn_title".localized
    }
}
