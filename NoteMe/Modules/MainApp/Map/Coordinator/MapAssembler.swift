//
//  MapAssembler.swift
//  NoteMe
//
//  Created by PavelKrm on 25.03.24.
//

import UIKit
import Storage

final class MapAssembler {
    
    private init() {}
    
    static func make(coordinator: MapCoordinatorProtocol,
                     container: Container,
                     delegate: MapDelegate?,
                     dto: LocationNotidicationDTO) -> UIViewController {
        
        let fileService: FileService = container.resolve()
        
        let vm = MapVM(coordinator: coordinator,
                       fileService: fileService,
                       delegate: delegate,
                       dto: dto)
        
        return MapVC(viewModel: vm)
    }
}
