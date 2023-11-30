//
//  OnboardSecondStepVM.swift
//  NoteMe
//
//  Created by PavelKrm on 28.11.23.
//

import UIKit

protocol OnboardSecondStepCoordinatorProtocol: AnyObject {
    
    func finish()
    func dismissedByUser()
}

final class OnboardSecondStepVM: OnboardSecondStepViewModelProtocol {
    
    private weak var coordinator: OnboardSecondStepCoordinatorProtocol?
    
    init(coordinator: OnboardSecondStepCoordinatorProtocol? = nil) {
        self.coordinator = coordinator
    }
    
    func finish() {
        ParametersHelper.set(.onboarded, value: true)
        coordinator?.finish()
    }
    
    func dismissedByUser() {
        coordinator?.dismissedByUser()
    }
}
