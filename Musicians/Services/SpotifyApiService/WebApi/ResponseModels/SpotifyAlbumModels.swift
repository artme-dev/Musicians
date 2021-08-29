//
//  SpotifyAlbumModels.swift
//  Musicians
//
//  Created by Артём on 29.08.2021.
//

import Foundation

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

struct SpotifyTrack: Decodable {
    var artists: [SpotifyArtist]
    var name: String
    var popularity: Int
}
