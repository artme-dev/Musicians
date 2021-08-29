//
//  SpotifyNetworkFetcher.swift
//  Musicians
//
//  Created by Артём on 23.08.2021.
//

import Foundation
import os

class SpotifyAuthService {
    private let networkAuthService = NetworkService<SpotifyAuthApiEndpoint>()
    private let clientID = "28686b8ae7674fbaa95ba3d4809506e5"
    private let clientSecrete = "2d6b0437d90944d2b3112349317ebfe3"
    
    private init() {}
    static let shared = SpotifyAuthService()
    
    private var currentToken: String?
    var token: String? {
        return currentToken
    }
    private var tokenExpirationDate: Date?
    
    var authKey: String {
        let key = "\(clientID):\(clientSecrete)"
        let encodedKey = Data(key.utf8).base64EncodedString()
        return encodedKey
    }
    
    func updateToken(completion: @escaping (String) -> Void) {
        let now = Date()
        guard (tokenExpirationDate == nil || tokenExpirationDate! <= now) else {
            completion(currentToken!)
            return
        }
        
        networkAuthService.request(.authorization) { [weak self] data, response, error in
            guard let self = self else { return }
            if let error = error {
                Logger.spotifyApi.info("Failure request to authorization: \(error.localizedDescription)")
                return
            }
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let response = try decoder.decode(SpotifyAuthResponse.self, from: data)
                let token = response.accessToken
                self.currentToken = token
                self.tokenExpirationDate = now + TimeInterval(response.expiresIn)
                
                completion(token)
                Logger.spotifyApi.info("Access token was updated")
            } catch {
                Logger.spotifyApi.info("Access token was updated")
            }
        }
    }
}
