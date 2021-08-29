//
//  SpotifyWebError.swift
//  Musicians
//
//  Created by Артём on 24.08.2021.
//

import Foundation

enum SpotifyWebError: LocalizedError {
    case informationResponse
    case authError
    case badRequest
    case serverError
    
    case notHTTPResponse
    
    case networkServiceError
    
    case unableToDecodeData
    case requestFailed
    
    var errorDescription: String? {
        switch self {
        
        case .informationResponse:
            return "Receive information response"
        case .authError:
            return "Response - Auth Error"
        case .badRequest:
            return "Response - Bad Request"
        case .serverError:
            return "Response - Server Error"
        case .notHTTPResponse:
            return "Cannot cast to HTTPResponse"
        case .networkServiceError:
            return ""
        case .unableToDecodeData:
            return ""
        case .requestFailed:
            return ""
        }
    }
}

class SpotifyWebManager {
    private init() {}
    
    static func handleResponse(_ response: HTTPURLResponse) -> Result<HTTPURLResponse, Error> {
        let statusCode = response.statusCode
        switch statusCode {
        case 100...199:
            return .failure(SpotifyWebError.informationResponse)
        case 200...299:
            return .success(response)
        case 401, 403:
            return .failure(SpotifyWebError.authError)
        case 400...499:
            return .failure(SpotifyWebError.badRequest)
        case 500...599:
            return .failure(SpotifyWebError.serverError)
        default:
            fatalError("Bad HTTP response status code: \(statusCode)")
        }
    }
}
