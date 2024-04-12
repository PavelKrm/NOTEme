//
//  TimerLabel.swift
//  NoteMe
//
//  Created by PavelKrm on 1.04.24.
//

import UIKit
import SnapKit

final class TimerLabel: UIView {
    
    
    private var timer = Timer()
    private var startDate: Date = .init()
    private var timeLeft: Int = 0
    
    private var startTimer: Bool = false {
        didSet {
            if startTimer {
                start()
            }
        }
    }
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = .appBoldFont.withSize(25.0)
        label.text = "00:00:00"
        return label
    }()
    
    var date: Date {
        get { startDate }
        set { startDate = newValue }
    }
    
    var interval: Int {
        get { timeLeft }
        set {
            timeLeft = newValue
            startTimer = true
        }
    }
    
    var showTimer: Bool {
        get { startTimer }
        set { startTimer = newValue }
    }
    
    init() {
        super.init(frame: .zero)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
        setupConstraints()
    }
    
    private func start() {
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.5,
                                     repeats: true,
                                     block: { _ in
            let timeIntervalNow = self.startDate.timeIntervalSinceNow
            let interval = timeIntervalNow.timeIntervalFromTimeLeft(time: self.timeLeft)
            if interval <= 0 {
                self.timeLabel.text = "completed"
                self.timeLabel.textColor = .appLightGrayText
                self.timer.invalidate()
            } else {
                self.timeLabel.textColor = .label
                self.timeLabel.text = interval.stingFromSeconds()
            }
        })
        
    }
    
    private func setupUI() {
        addSubview(timeLabel)
    }
    
    private func setupConstraints() {
        
        timeLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
