//
//  AddLocationNotificationVM.swift
//  NoteMe
//
//  Created by PavelKrm on 27.02.24.
//

import UIKit
import Storage
import MapKit

protocol AddLocationNotificationCoordinatorProtocol: AnyObject {
    
    func finish()
    func openMap(delegate: MapDelegate, dto: LocationNotidicationDTO)
}

final class AddLocationNotificationVM:
    AddLocationNotificationViewModelProtocol,
    MapDelegate {
    
    var updatePreview: ((UIImage?) -> Void)?
    var locationDidSelect: ((LocationNotidicationDTO) -> Void)?
    
    var title: String?
    var subtitle: String?
    var dto: LocationNotidicationDTO? {
        didSet {
            if let dto {
                updatePreview?(fileService.loadImage(id: dto.id))
            }
        }
    }
    
    private weak var coordinator: AddLocationNotificationCoordinatorProtocol?
    private var storage: LocationNotificationStorage
    private var fileService: FileService
    private var locationManager: CLLocationManager = .init()
    
    init(coordinator: AddLocationNotificationCoordinatorProtocol,
         storage: LocationNotificationStorage,
         fileService: FileService,
         dto: LocationNotidicationDTO?) {
        self.coordinator = coordinator
        self.storage = storage
        self.fileService = fileService
        self.dto = dto
        
        title = dto?.title
        subtitle = dto?.subtitle
        
        askPermission()
        bind()
    }
    
    func createNotification() {
        
        guard
            var dto, let title
        else { return }
        
        dto.title = title
        dto.subtitle = subtitle
        storage.updateOrCreate(dto: dto, completion: nil)
        coordinator?.finish()
    }
    
    func openMapView() {
        if let oldDto = dto {
            coordinator?.openMap(delegate: self, dto: oldDto)
        } else {
            if let userLocation = locationManager.location?.coordinate {
             
                let newDto = LocationNotidicationDTO(
                    date: .now,
                    title: title ?? "",
                    subtitle: subtitle, 
                    latSpan: 0.0,
                    longSpan: 0.0,
                    latCenter: userLocation.latitude,
                    longCenter: userLocation.longitude,
                    imagePathStr: "")
                
                coordinator?.openMap(delegate: self, dto: newDto)
            }
        }
    }
    
    func cancelDidTap() {
        coordinator?.finish()
    }
    
    private func askPermission() {
        locationManager.requestAlwaysAuthorization()
    }
    
    private func bind() {
        locationDidSelect = { [weak self] dto in
            self?.dto = dto
        }
    }
}
