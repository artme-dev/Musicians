//
//  Logger.swift
//  Musicians
//
//  Created by Артём on 25.08.2021.
//

import Foundation
import os

extension Logger {
    private static var subsystem = Bundle.main.bundleIdentifier!
    static let spotifyApi = Logger(subsystem: subsystem, category: "spotifyApi")
    static let networkService = Logger(subsystem: subsystem, category: "networkService")
}
