//
//  AppDelegate.swift
//  Musicians
//
//  Created by Артём on 23.08.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let service = SpotifyWebService.shared
        service.getArtistAlbums(artistID: "3EsjO0y0DE1GC453Sgyr7Z") { albums in
            let sorted = albums.sorted {
                $0.parsedDate! > $1.parsedDate!
            }
            sorted.map { album in
                print("---")
                print(album)
            }
        }
        return true
    }
}
