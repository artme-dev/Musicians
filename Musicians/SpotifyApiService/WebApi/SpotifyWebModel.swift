//
//  SpotifyWebModel.swift
//  Musicians
//
//  Created by Артём on 24.08.2021.
//

import Foundation

struct SpotifyRegularErrorResponse: Decodable {
    var status: String
    var message: String
    
    enum ErrorResponse: CodingKey {
        case error
    }
    enum ErrorDescription: CodingKey {
        case status
        case message
    }
    
    enum GiftKeys: CodingKey {
      case toy
    }
    
    init(from decoder: Decoder) throws {
        let responseContainer = try decoder.container(keyedBy: ErrorResponse.self)
        let descriptionContainer = try responseContainer.nestedContainer(keyedBy: ErrorDescription.self,
                                                                         forKey: .error)
        status = try descriptionContainer.decode(String.self, forKey: .status)
        message = try descriptionContainer.decode(String.self, forKey: .message)
    }
}

struct SpotifySearchResults: Decodable {
    var artists: SpotifyArtistsList
}

struct SpotifyArtistsList: Decodable {
    var total: Int
    var items: [SpotifyArtist]
}
struct SpotifyArtist: Decodable {
    var id: String
    var name: String
    var popularity: Int?
    var genres: [String]?
}

struct SpotifyAlbumsBatch: Decodable {
    var total: Int
    var items: [SpotifyAlbum]
    var next: String?
}
struct SpotifyAlbum: Decodable {
    var id: String
    var name: String
    var releaseDate: String
    
    var parsedDate: Date? {
        let partsCount = releaseDate.components(separatedBy: "-").count
        let dateFormat: String
        switch partsCount {
        case 1:
            dateFormat = "yyyy"
        case 2:
            dateFormat = "yyyy-MM"
        case 3:
            dateFormat = "yyyy-MM-dd"
        default:
            return nil
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        let date = dateFormatter.date(from: releaseDate)
        return date
    }
}

struct SpotifyArtistTopTracks: Decodable {
    var tracks: [SpotifyTrack]
}

struct SpotifyTrack: Decodable {
    var artists: [SpotifyArtist]
    var name: String
    var popularity: Int
}
