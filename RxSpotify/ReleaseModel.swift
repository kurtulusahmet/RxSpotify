//
//  ReleaseModel.swift
//  RxSpotify
//
//  Created by Kurtulus Ahmet on 15.11.2017.
//  Copyright © 2017 Kurtulus Ahmet. All rights reserved.
//

import Foundation

class ReleaseModel: BaseModel {
    var name: String?
    var artistName: String?
    var thumbnail: String?
    var image: String?
    var url: String?
    
    init(_ name: String?, _ artistName: String?, _ thumbnail: String?, _ image: String?, _ url: String?)
    {
        self.name = name
        self.artistName = artistName
        self.thumbnail = thumbnail
        self.image = image
        self.url = url
    }
}
