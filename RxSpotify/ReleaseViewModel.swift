//
//  ReleaseViewModel.swift
//  RxSpotify
//
//  Created by Kurtulus Ahmet on 15.11.2017.
//  Copyright © 2017 Kurtulus Ahmet. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ReleaseViewModel {
    
    var didConnectionFail = Variable(false)
    var releases = Variable([ReleaseModel]())
    var offset = 0
    
    init() {
        self.loadMore()
    }
    
    func loadMore() {
        print("offset")
        print(self.offset)
        ServiceManager.sharedInstance.getReleases(paramaters: ["country":"TR","offset":"\(self.offset)"]) { (releases, error) in
            if error == nil {
                self.offset = self.offset + 20
                self.releases.value.append(contentsOf: releases)
            }
        }
    }
}
