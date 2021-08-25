//
//  NetworkService.swift
//  Musicians
//
//  Created by Артём on 23.08.2021.
//

import Foundation
import os

class NetworkService<EndPoint: EndPointType>: NetworkServiceType {

    private var session: URLSession = URLSession.shared
    private var requestBuilder: URLRequestBuilderType

    init() {
        self.requestBuilder = URLRequestBuilder(cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                                timeoutInterval: 10.0)
    }

    func request(_ endPoint: EndPoint, completion: @escaping NetworkRequestCompletion) {
        do {
            guard let urlRequest = requestBuilder.buildRequest(from: endPoint) else {
                throw NetworkServiceError.cannotBuildRequest
            }
            session.dataTask(with: urlRequest) { [weak self] data, response, error in
                guard let self = self else { return }
                completion((data, response, error))
                self.logResponse(response)
            }.resume()
            logRequest(urlRequest)
        } catch {
            completion((nil, nil, error))
        }
    }
    
    private func logRequest(_ request: URLRequest) {
        let headers = request.allHTTPHeaderFields
        let requestInfo = """
            Request: \(request.httpMethod ?? "<nil>") \(request.url?.absoluteString ?? "<nil>")
            Content-Type: \(headers?["Content-Type"] ?? "<nil>")
            Authorization: \(headers?["Authorization"] ?? "<nil>")
            """
        Logger.networkService.info("\(requestInfo)")
    }
    
    private func logResponse(_ response: URLResponse?) {
        guard let httpResponse = response as? HTTPURLResponse else { return }
        let responseInfo = """
            Response: \(httpResponse.url?.absoluteString ?? "<nil>")
            Status code: \(httpResponse.statusCode)
            """
        Logger.networkService.info("\(responseInfo)")
    }
}
