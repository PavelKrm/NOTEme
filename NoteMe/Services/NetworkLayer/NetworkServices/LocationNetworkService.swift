//
//  LocationNetworkService.swift
//  NoteMe
//
//  Created by PavelKrm on 22.04.24.
//

import Foundation
import CoreLocation

final class LocationNetworkService {
    
    private let session = NetworkSessionProvider()
    
    func getNearBy(coordinates: CLLocationCoordinate2D,
                   completion: @escaping ([NearByResponseModel.Result]) -> Void) {
        
        let requestModel = NearByRequestModel(coordinates: coordinates)
        let request = NearByRequest(model: requestModel)
        session.send(request: request) { response in
            completion(response?.results ?? [])
        }
    }
}
