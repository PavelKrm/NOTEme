//
//  NetworkRequest.swift
//  NoteMe
//
//  Created by PavelKrm on 22.04.24.
//

import Foundation

enum NetworkHTTPMethod: String {
    case get = "GET"
}

protocol NetworkRequest {
    
    associatedtype ResponseModel: Decodable
    
    var url: URL { get }
    var method: NetworkHTTPMethod { get }
    var headers: [String: String] { get }
    var body: Data? { get }
}
