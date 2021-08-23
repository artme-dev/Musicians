//
//  NetworkService.swift
//  Musicians
//
//  Created by Артём on 23.08.2021.
//

import Foundation


class NetworkService<EndPoint: EndPointType>: NetworkServiceType{
    
    private var session: URLSession = URLSession.shared
    private var requestBuilder: URLRequestBuilderType
    
    init(){
        self.requestBuilder = URLRequestBuilder(cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                                timeoutInterval: 10.0)
    }
    
    func request(_ endPoint: EndPoint, completion: @escaping NetworkRequestCompletion){
        do{
            guard let urlRequest = requestBuilder.buildRequest(from: endPoint) else {
                throw NetworkServiceError.cannotBuildRequest
            }
            
            session.dataTask(with: urlRequest) { data, response, error in
                completion(data, response, error)
            }.resume()
        } catch {
            completion(nil, nil, error)
        }
    }
}
