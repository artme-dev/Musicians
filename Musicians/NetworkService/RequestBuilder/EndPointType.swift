//
//  EndPointType.swift
//  Musicians
//
//  Created by Артём on 23.08.2021.
//

import Foundation

public typealias Parameters = [String: Any]
public typealias HTTPHeaders = [String: String]

protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var parameters: EndPointParameters? { get }
    var headers: HTTPHeaders? { get }
}

struct EndPointParameters {
    var bodyParameters: Parameters?
    var urlParameters: Parameters?
    var headers: HTTPHeaders?
}
