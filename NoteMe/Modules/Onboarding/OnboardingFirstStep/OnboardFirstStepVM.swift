//
//  OnboardFirstStepVM.swift
//  NoteMe
//
//  Created by PavelKrm on 28.11.23.
//

import UIKit

protocol OnboardFirstStepCoordinatorProtocol: AnyObject {
    
    func openNextStep()
}

final class OnboardFirstStepVM: OnboardFirstStepViewModelProtocol {
    
    private weak var coordinator: OnboardFirstStepCoordinatorProtocol?
    
    init(coordinator: OnboardFirstStepCoordinatorProtocol? = nil) {
        self.coordinator = coordinator
    }
    
    func nextDidTap() {
        coordinator?.openNextStep()
    }
}
