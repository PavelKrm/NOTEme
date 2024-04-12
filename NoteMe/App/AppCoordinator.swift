//
//  AppCoordinator.swift
//  NoteMe
//
//  Created by PavelKrm on 21.11.23.
//

import UIKit
import Storage

final class AppCoordinator: Coordinator {
    
    private let container: Container
    
    private let windowManager: WindowManager
    
    init(container: Container) {
        self.container = container
        self.windowManager = container.resolve()
    }
    
    func startApp() {
        
        loadBackup()
        
        let authenticated = ParametersHelper.get(.authenticated)
        let onboarded = ParametersHelper.get(.onboarded)
        
        if authenticated {
//FIXME: - TEST CODE
//            ParametersHelper.set(.authenticated, value: false)
//            ParametersHelper.set(.onboarded, value: false)
            onboarded ? openMainApp() : openOnboardingModule()
        } else {
            openAuth()
        }
    }

    
    private func openAuth() {
        
        let coordinator = LoginCoordinator(container: container)
        children.append(coordinator)
        coordinator.onDidFinish = { [weak self] coordinator in
            self?.children.removeAll { $0 == coordinator }
            self?.startApp()
        }
        
        let vc = coordinator.start()

        let window = windowManager.get(type: .main)
        window.rootViewController = vc
        windowManager.show(type: .main)
    }
    
    private func openOnboardingModule() {
        
        let coordinator = OnboardFirstStepCoordinator()
        children.append(coordinator)
        
        coordinator.onDidFinish = { [weak self] coordinator in
            self?.children.removeAll() { coordinator == $0 }
            self?.startApp()
        }
        
        let vc = coordinator.start()
        let window = windowManager.get(type: .main)
        window.rootViewController = vc
        windowManager.show(type: .main)
    }
    
    private func openMainApp() {
        
        let coordinator = MainTabBarCoordinator(container: container)
        children.append(coordinator)
        
        coordinator.onDidFinish = { [weak self] coordinator in
            self?.children.removeAll { $0 == coordinator }
            self?.startApp()
        }
        
        let vc = coordinator.start()
        
        let window = windowManager.get(type: .main)
        window.rootViewController = vc
        windowManager.show(type: .main)
    }
    
    //MARK: - TEST CODE
    
    private func loadBackup() {
        let database = FirebaseBackupService()
        database.loadBackup()
    }
}



