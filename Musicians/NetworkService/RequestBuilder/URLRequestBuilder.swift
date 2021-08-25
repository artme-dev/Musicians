//
//  URLRequestBuilder.swift
//  Musicians
//
//  Created by Артём on 23.08.2021.
//

import Foundation
import os

protocol URLRequestBuilderType {
    func buildRequest(from endPoint: EndPointType) -> URLRequest?
}

class URLRequestBuilder: URLRequestBuilderType {
    let cachePolicy: URLRequest.CachePolicy
    let timeoutInterval: TimeInterval
    let urlParametersEncoder: ParameterEncoderType
    let bodyParametersEncoder: ParameterEncoderType
    
    init(cachePolicy: URLRequest.CachePolicy,
         timeoutInterval: TimeInterval,
         urlParametersEncoder: ParameterEncoderType = URLParameterEncoder(),
         bodyParametersEncoder: ParameterEncoderType = JSONParameterEncoder()) {
        
        self.cachePolicy = cachePolicy
        self.timeoutInterval = timeoutInterval
        self.bodyParametersEncoder = bodyParametersEncoder
        self.urlParametersEncoder = urlParametersEncoder
    }

    func buildRequest(from endPoint: EndPointType) -> URLRequest? {
        do {
            let url = endPoint.baseURL.appendingPathComponent(endPoint.path)
            var request = makeRequest(from: url)
            request.httpMethod = endPoint.httpMethod.rawValue
        
            add(headers: endPoint.headers, to: &request)
            
            if let params = endPoint.parameters {
                try configureParams(for: &request,
                                    urlParameters: params.urlParameters,
                                    bodyParameters: params.bodyParameters)
                add(headers: params.headers, to: &request)
            }
            bodyParametersEncoder.setContentTypeIfNil(for: &request)
            return request
            
        } catch let error {
            Logger.networkService.error("Cannot build URL Request: \(error.localizedDescription)")
            return nil
        }
    }
    
    private func makeRequest(from url: URL) -> URLRequest {
        return URLRequest(url: url,
                          cachePolicy: cachePolicy,
                          timeoutInterval: timeoutInterval)
    }
    
    private func configureParams(for request: inout URLRequest,
                                 urlParameters: Parameters? = nil,
                                 bodyParameters: Parameters? = nil) throws {
        
        if let bodyParameters = bodyParameters {
            try bodyParametersEncoder.add(bodyParameters, to: &request)
        }
        if let urlParameters = urlParameters {
            try urlParametersEncoder.add(urlParameters, to: &request)
        }
    }
    
    private func add(headers: HTTPHeaders?, to request: inout URLRequest) {
        guard let headers = headers else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
}
