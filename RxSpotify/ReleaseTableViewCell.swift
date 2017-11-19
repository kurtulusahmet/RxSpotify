//
//  ReleaseTableViewCell.swift
//  RxSpotify
//
//  Created by Kurtulus Ahmet on 16.11.2017.
//  Copyright © 2017 Kurtulus Ahmet. All rights reserved.
//

import UIKit
import Hero

class ReleaseTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    func populateView(_ release:ReleaseModel){
        
        thumbnailImageView.heroID = release.image ?? "image"
        artistLabel.heroID = release.artistName ?? "artist"
        nameLabel.heroID = release.name ?? "name"
        
        nameLabel.text = release.name ?? "Unknown"
        artistLabel.text = release.artistName ?? "Unknown"
        thumbnailImageView.fetchImage(forPath: release.thumbnail ?? "")
    }

}
