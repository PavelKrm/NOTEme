//
//  MapCoordinator.swift
//  NoteMe
//
//  Created by PavelKrm on 25.03.24.
//

import UIKit
import Storage

final class MapCoordinator: Coordinator {
    
    private let container: Container
    private let dto: LocationNotidicationDTO
    private weak var delegate: MapDelegate?
    
    init(container: Container,
         delegate: MapDelegate,
         dto: LocationNotidicationDTO) {
        self.container = container
        self.delegate = delegate
        self.dto = dto
    }
    
    override func start() -> UIViewController {
        return MapAssembler.make(coordinator: self,
                                 container: container,
                                 delegate: delegate,
                                 dto: dto)
    }
}

extension MapCoordinator: MapCoordinatorProtocol {}
