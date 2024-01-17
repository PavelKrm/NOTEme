//
//  ProfileCoordinator.swift
//  NoteMe
//
//  Created by PavelKrm on 19.12.23.
//

import UIKit

final class ProfileCoordinator: Coordinator {
    
    private let container: Container
    
    init(container: Container) {
        self.container = container
    }
    
    override func start() -> UIViewController {
        return ProfileAssembler.make(container: container)
    }
}
