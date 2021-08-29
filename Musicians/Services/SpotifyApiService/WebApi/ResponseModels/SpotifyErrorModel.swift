//
//  SpotifyErrorResponse.swift
//  Musicians
//
//  Created by Артём on 29.08.2021.
//

import Foundation

struct SpotifyErrorResponse: Decodable {
    var status: String
    var message: String
    
    enum ErrorResponse: CodingKey {
        case error
    }
    enum ErrorDescription: CodingKey {
        case status
        case message
    }
    
    init(from decoder: Decoder) throws {
        let responseContainer = try decoder.container(keyedBy: ErrorResponse.self)
        let descriptionContainer = try responseContainer.nestedContainer(keyedBy: ErrorDescription.self,
                                                                         forKey: .error)
        status = try descriptionContainer.decode(String.self, forKey: .status)
        message = try descriptionContainer.decode(String.self, forKey: .message)
    }
}
