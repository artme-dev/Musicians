//
//  SpotifyApi.swift
//  Musicians
//
//  Created by Артём on 23.08.2021.
//

import Foundation

enum SpotifyAuthApiEndpoint {
    case authorization
}

extension SpotifyAuthApiEndpoint: EndPointType {
    var stringBaseURL: String {
        return "https://accounts.spotify.com/api/"
    }
    var baseURL: URL {
        guard let url = URL(string: stringBaseURL) else {
            fatalError("baseURL could not be configured.")
        }
        return url
    }
    var path: String {
        switch self {
        case .authorization:
            return "token"
        }
    }
    var httpMethod: HTTPMethod {
        return .post
    }
    var parameters: EndPointParameters? {
        switch self {
        case .authorization:
            let authService = SpotifyAuthService.shared
            return EndPointParameters(bodyParameters: nil,
                                      urlParameters: ["grant_type": "client_credentials"],
                                      headers: ["Authorization": "Basic \(authService.authKey)"])
            
        }
    }
    var headers: HTTPHeaders? {
        return nil
    }
}
