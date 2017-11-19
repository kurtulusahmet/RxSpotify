//
//  RxSpotifyDelegate.swift
//  RxSpotify
//
//  Created by Kurtulus Ahmet on 15.11.2017.
//  Copyright © 2017 Kurtulus Ahmet. All rights reserved.
//

import Foundation

protocol RxSpotifyDelegate {
    func dataRetrieved(_ releases:[BaseModel])
    func spotifyRequestDidFail()
}
