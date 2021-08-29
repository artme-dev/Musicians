//
//  SpotifyWebModel.swift
//  Musicians
//
//  Created by Артём on 24.08.2021.
//

import Foundation

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
    var images: [SpotifyImageModel]
}

struct SpotifyArtistTopTracks: Decodable {
    var tracks: [SpotifyTrack]
}
