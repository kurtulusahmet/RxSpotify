//
//  FeaturedPlaylistViewModel.swift
//  RxSpotify
//
//  Created by Kurtulus Ahmet on 16.11.2017.
//  Copyright © 2017 Kurtulus Ahmet. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class FeaturedPlaylistViewModel {
    
    var didConnectionFail = Variable(false)
    var featuredPlaylists = Variable([FeaturedPlaylistModel]())
    var offset = 0
    
    init() {
        self.loadMore()
    }
    
    func loadMore() {
        print("offset")
        print(self.offset)
        let currentTimestamp = getCurrentTimestamp()
        ServiceManager.sharedInstance.getFeaturedPlaylists(paramaters: ["locale":"tr_TR","country":"TR","timestamp":currentTimestamp,"offset":"\(self.offset)"]) { (featuredPlaylists, error) in
            if error == nil {
                self.offset = self.offset + 20
                self.featuredPlaylists.value.append(contentsOf: featuredPlaylists)
            }
        }
    }
    
    private func getCurrentTimestamp() -> String {
        let now = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return dateFormatter.string(for: now)!
    }
}
