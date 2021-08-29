//
//  SpotifyAuthModel.swift
//  Musicians
//
//  Created by Артём on 23.08.2021.
//

import Foundation

struct SpotifyAuthResponse: Decodable {
    var accessToken: String
    var tokenType: String
    var expiresIn: Int
}
