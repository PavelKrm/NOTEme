//
//  AppCoordinator.swift
//  NoteMe
//
//  Created by PavelKrm on 21.11.23.
//

import UIKit

final class AppCoordinator: Coordinator {
    
    private var window: UIWindow
    
    init(scene: UIWindowScene) {
        self.window = UIWindow(windowScene: scene)
    }
    
    func startApp() {
        
        if ParametersHelper.get(.authenticated) {
            //FIXME: - TEST CODE
//            ParametersHelper.set(.authenticated, value: false)
            //open onboarding or mainApp
            openOnboardingVodule()
        } else {
            openAuth()
        }
    }

    
    private func openAuth() {
        
        let coordinator = LoginCoordinator()
        children.append(coordinator)
        coordinator.onDidFinish = { [weak self] coordinator in
            self?.children.removeAll { $0 == coordinator }
            self?.startApp()
        }
        
        let vc = coordinator.start()

        window.rootViewController = vc
        window.makeKeyAndVisible()
    }
    
    private func openOnboardingVodule() {
        
        let coordinator = OnboardFirstStepCoordinator()
        children.append(coordinator)
        
        coordinator.onDidFinish = { [weak self] coordinator in
            self?.children.removeAll() { coordinator == $0 }
            self?.startApp()
        }
        
        let vc = coordinator.start()
        window.rootViewController = vc
        window.makeKeyAndVisible()
    }
}
