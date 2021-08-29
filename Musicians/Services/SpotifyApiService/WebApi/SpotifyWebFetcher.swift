//
//  SpotifyWebFetcher.swift
//  Musicians
//
//  Created by Артём on 24.08.2021.
//

import Foundation
import os

class SpotifyWebFetcher {
    private var networkService = NetworkService<SpotifyWebApiEndpoint>()
    private var authService = SpotifyAuthService.shared
    
    private init() {}
    static var shared = SpotifyWebFetcher()
    
    func request(_ endPoint: SpotifyWebApiEndpoint,
                 completion: @escaping (Data?, Error?)->Void) {
        
        authService.updateToken { [weak self] token in
            SpotifyWebApiEndpoint.accessToken = token
            
            guard let self = self else { return }
            self.networkService.request(endPoint) { data, response, error in
                if let error = error {
                    completion(nil, error)
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(nil, SpotifyWebError.notHTTPResponse)
                    return
                }
                
                let result = SpotifyWebManager.handleResponse(httpResponse)
                switch result {
                case .success(_):
                    completion(data, nil)
                case .failure(let error):
                    completion(nil, error)
                }
            }
        }
    }
    func decodeModel<T: Decodable>(from data: Data?) throws -> T? {
        guard let data = data else { return nil }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        let response = try decoder.decode(T.self, from: data)
        return response
    }
}
