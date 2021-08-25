//
//  SpotifyWebApi.swift
//  Musicians
//
//  Created by Артём on 24.08.2021.
//

import Foundation

enum SpotifyWebApiEndpoint {
    static var accessToken: String = ""
    
    case artistSearch(_ keywords: String)
    case artistInfo(_ artistId: String)
    case artistAlbums(_ artistId: String, limit: Int, offset: Int)
    case artistTopTracks(_ artistId: String)
}

extension SpotifyWebApiEndpoint: EndPointType {
    private var stringBaseURL: String {
        return "https://api.spotify.com/v1/"
    }
    
    var baseURL: URL {
        guard let url = URL(string: stringBaseURL) else {
            fatalError("baseURL could not be configured.")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .artistSearch(_):
            return "search"
        case .artistInfo(let artistId):
            return "artists/\(artistId)"
        case .artistAlbums(let artistId, _, _):
            return "artists/\(artistId)/albums"
        case .artistTopTracks(let artistId):
            return "artists/\(artistId)/top-tracks"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var parameters: EndPointParameters? {
        switch self {
        case .artistSearch(let keywords):
            return EndPointParameters(bodyParameters: nil,
                                      urlParameters: ["type": "artist",
                                                      "q": "\(keywords)"],
                                      headers: nil)
        case .artistAlbums(_, let limit, let offset):
            let pureTypes = "album,single"
            return EndPointParameters(bodyParameters: nil,
                                      urlParameters: ["include_groups": pureTypes,
                                                      "limit": "\(limit)",
                                                      "offset": "\(offset)"],
                                      headers: nil)
        case .artistInfo(_):
            return nil
        case .artistTopTracks(_):
            return EndPointParameters(bodyParameters: nil,
                                      urlParameters: ["market": "RU"],
                                      headers: nil)
        }
    }
    
    var headers: HTTPHeaders? {
        return ["Authorization": "Bearer \(SpotifyWebApiEndpoint.accessToken)"]
    }
}

extension SpotifyWebApiEndpoint: CustomStringConvertible {
    var description: String {
        let name: String
        switch self {
        case .artistSearch(_):
            name = "Artist search"
        case .artistInfo(_):
            name = "Artist info"
        case .artistAlbums(_, _, _):
            name = "Artist albums"
        case .artistTopTracks(_):
            name = "Artist top tracks"
        }
        
        return "'\(name)' endpoint"
    }
}
