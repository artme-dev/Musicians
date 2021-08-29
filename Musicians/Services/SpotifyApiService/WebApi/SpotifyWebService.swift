//
//  SpotifyWebService.swift
//  Musicians
//
//  Created by Артём on 24.08.2021.
//

import Foundation
import os

class SpotifyWebService {
    private var networkFetcher = SpotifyWebFetcher.shared
    
    private init() {}
    static var shared = SpotifyWebService()
    
    private func request<T: Decodable>(endpoint: SpotifyWebApiEndpoint, completion: @escaping (T?)->Void) {
        networkFetcher.request(endpoint) { [weak self] data, error in
            guard let self = self else { return }
            if let error = error {
                Logger.spotifyApi.error("Failure request to \(endpoint): \(error.localizedDescription)")
                return
            }
            do {
                let result: T? = try self.networkFetcher.decodeModel(from: data)
                completion(result)
            } catch {
                Logger.spotifyApi.error("Cannot decode \(endpoint) response: \(error.localizedDescription)")
            }
        }
    }

    func searchArtist(keywords: String, completion: @escaping ([SpotifyArtist])->Void) {
        request(endpoint: .artistSearch(keywords)) { (result: SpotifySearchResults?) in
            completion(result?.artists.items ?? [])
        }
    }
    
    func getArtistInfo(artistID: String, completion: @escaping (SpotifyArtist?)->Void) {
        request(endpoint: .artistInfo(artistID)) { (result: SpotifyArtist?) in
            completion(result)
        }
    }
    
    func getArtistAlbums(artistID: String, completion: @escaping ([SpotifyAlbum])->Void) {
        var resultAlbums: [SpotifyAlbum] = []
        let limit = 20
        
        getArtistAlbums(artistID: artistID, offset: 0, limit: limit) { albums, isFin in
            resultAlbums.append(contentsOf: albums)
            Logger.spotifyApi.info("Fetch artist \(artistID) albums batch size of \(albums.count)")
            
            if isFin {
                completion(resultAlbums)
                Logger.spotifyApi.info("Fetch \(resultAlbums.count) artist \(artistID) albums")
            }
        }
    }
    
    private func getArtistAlbums(artistID: String,
                                 offset: Int,
                                 limit: Int,
                                 completion: @escaping ([SpotifyAlbum], Bool)->Void) {
        
        let endpoint: SpotifyWebApiEndpoint = .artistAlbums(artistID, limit: limit, offset: offset)
        request(endpoint: endpoint) { [weak self] (result: SpotifyAlbumsBatch?) in
            guard let self = self, let result = result else { return }
            
            let isFin = result.next == nil
            completion(result.items, isFin)
            
            if !isFin {
                self.getArtistAlbums(artistID: artistID, offset: offset + limit, limit: limit) {
                    completion($0, $1)
                }
            }
        }
    }
    
    func getArtistTopTracks(artistID: String, completion: @escaping ([SpotifyTrack])->Void) {
        request(endpoint: .artistTopTracks(artistID)) { (result: SpotifyArtistTopTracks?) in
            completion(result?.tracks ?? [])
        }
    }
    
}
