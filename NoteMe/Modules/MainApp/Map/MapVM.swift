//
//  MapVM.swift
//  NoteMe
//
//  Created by PavelKrm on 25.03.24.
//

import UIKit
import Storage
import MapKit

protocol MapDelegate: AnyObject {
    var locationDidSelect: ((LocationNotidicationDTO) -> Void)? { get set }
}

protocol MapCoordinatorProtocol: AnyObject {
    
    func finish()
}

protocol MapViewAdapterProtocol: AnyObject {
    
    var searchDidSelect: ((NearByResponseModel.Result) -> Void)? { get set }
    
    func reloadData(with: [NearByResponseModel.Result])
    func makeTableView() -> UITableView
}

final class MapVM: MapViewModelProtocol {
    
    var setRegion: ((MKCoordinateRegion) -> Void)?
    
    weak var delegate: MapDelegate?
    
    private var dto: LocationNotidicationDTO
    
    private weak var coordinator: MapCoordinatorProtocol?
    private var fileService: FileService
    
    init(coordinator: MapCoordinatorProtocol?,
         fileService: FileService,
         delegate: MapDelegate?,
         dto: LocationNotidicationDTO) {
        self.coordinator = coordinator
        self.fileService = fileService
        self.delegate = delegate
        self.dto = dto
    }
    
    func viewDidLoad() {
        
        let center = CLLocationCoordinate2D(latitude: dto.latCenter,
                                            longitude: dto.longCenter)
  
        if dto.latSpan == 0.0 && dto.longSpan == 0.0 {
            
            let viewRegion = MKCoordinateRegion(center: center,
                                                latitudinalMeters: 500.0,
                                                longitudinalMeters: 500.0)
            setRegion?(viewRegion)
        } else {
            let span = MKCoordinateSpan(latitudeDelta: dto.latSpan,
                                        longitudeDelta: dto.longSpan)

            let region = MKCoordinateRegion(center: center, span: span)
            setRegion?(region)
        }
    }
    
    func selectLocation(region: MKCoordinateRegion,
                        view: UIView,
                        circle: UIView,
                        mapView: MKMapView) {
        
        let width = mapView.frame.width
        let height = circle.frame.height * 2
        let screenshotSize = CGSize(width: width, height: height)
        let pointY: Double = -(circle.center.y)
        let origin = CGPoint(x: .zero, y: pointY)
        let contentRect = CGRect(origin: origin, size: view.bounds.size)
        
        UIGraphicsBeginImageContextWithOptions(screenshotSize,
                                               false,
                                               UIScreen.main.scale)
        view.drawHierarchy(in: contentRect, afterScreenUpdates: true)
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        fileService.saveImage(id: dto.id, image: screenshot)
        
        dto.longSpan = region.span.longitudeDelta
        dto.latSpan = region.span.latitudeDelta
        dto.longCenter = region.center.longitude
        dto.latCenter = region.center.latitude
        
        delegate?.locationDidSelect?(dto)
        coordinator?.finish()
    }
    
    func cancel() {
        coordinator?.finish()
    }
    
}
