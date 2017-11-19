//
//  FeaturedPlaylistModel.swift
//  RxSpotify
//
//  Created by Kurtulus Ahmet on 15.11.2017.
//  Copyright © 2017 Kurtulus Ahmet. All rights reserved.
//

import Foundation

struct FeaturedPlaylistModel {
    var name: String?
    var ownerName: String?
    var image: String?
    var url: String?
    
    init(_ name: String?, _ ownerName: String?, _ image: String?, _ url: String?)
    {
        self.name = name
        self.ownerName = ownerName
        self.image = image
        self.url = url
    }
}
