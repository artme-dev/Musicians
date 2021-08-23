//
//  URLParameterEncoder.swift
//  Musicians
//
//  Created by Артём on 23.08.2021.
//

import Foundation

class URLParameterEncoder: ParameterEncoderType{
    var encodingTypeFieldValue = "application/x-www-form-urlencoded; charset=utf8"
    
    func add(_ parameters: Parameters, to urlRequest: inout URLRequest){
        guard let url = urlRequest.url else { return }
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        
        guard
            !parameters.isEmpty,
            var urlComponents = urlComponents
        else { return }
        
        urlComponents.queryItems = URLParameterEncoder.queryItems(from: parameters)
        urlRequest.url = urlComponents.url
        
        setContentTypeIfNil(for: &urlRequest)
    }
    
    
    private static func queryItems(from parameters: Parameters) -> [URLQueryItem]{
        var queryItems: [URLQueryItem] = []
        for (parameterName, parameterValue) in parameters{
            let value = "\(parameterValue)"
            let percentEncodedValue = value.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
            let item = URLQueryItem(name: parameterName, value: percentEncodedValue)
            queryItems.append(item)
        }
        return queryItems
    }
}
