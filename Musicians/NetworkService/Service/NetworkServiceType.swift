//
//  NetworkService.swift
//  Musicians
//
//  Created by Артём on 23.08.2021.
//

import Foundation

public typealias NetworkRequestCompletion = (_ data: Data?,_ response: URLResponse?,_ error: Error?)->()

enum NetworkServiceError: String, Error{
    case cannotBuildRequest = "Cannot build request from endpoint"
}

protocol NetworkServiceType: AnyObject  {
    associatedtype EndPoint: EndPointType
    
    func request(_ route: EndPoint, completion: @escaping NetworkRequestCompletion)
}
