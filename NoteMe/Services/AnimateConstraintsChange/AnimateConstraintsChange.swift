//
//  AnimateConstraintsChange.swift
//  NoteMe
//
//  Created by PavelKrm on 20.11.23.
//

import UIKit
import SnapKit

final class AnimateConstraintsChange {
    
    func keyboardEffect(for vc: UIViewController,
                            target: UIView,
                        keyboardFrame: CGRect,
                        with padding: CGFloat = 16) {
        
        let heightTopSafeArea = vc.view.safeAreaLayoutGuide.layoutFrame.minY
        let maxY = target.frame.maxY + padding + heightTopSafeArea
        let keyboardY = keyboardFrame.minY
        let diff = maxY - keyboardY
        
        if maxY > keyboardY {
            animateChange(vc: vc, target: target, with: -diff)
        } else if maxY < keyboardY {
            animateChange(vc: vc, target: target, with: .zero)
        }
    }
    
    private func animateChange(vc: UIViewController,
                               target: UIView,
                               with diff: CGFloat) {
        UIView.animate(withDuration: 0.25) {
            target.snp.updateConstraints { make in
                make.centerY.equalToSuperview().offset(diff)
            }
            vc.view.layoutIfNeeded()
        }
    }
}
