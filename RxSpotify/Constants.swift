//
//  Constants.swift
//  RxSpotify
//
//  Created by Kurtulus Ahmet on 15.11.2017.
//  Copyright © 2017 Kurtulus Ahmet. All rights reserved.
//

import Foundation

struct Constants {
    struct Config {
        static let clientID = "#################"
        static let clientSecret = "#################"
    }
    
    struct Network {
        static let baseUrl = "https://api.spotify.com/v1/"
        static let authUrl = "https://accounts.spotify.com/api/token"
    }
    
    struct ApiLookUp {
        static let newReleases = "browse/new-releases"
        static let featuredPlaylists = "browse/featured-playlists"
    }
}
