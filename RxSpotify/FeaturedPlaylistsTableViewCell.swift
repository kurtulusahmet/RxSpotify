//
//  FeaturedPlaylistsTableViewCell.swift
//  RxSpotify
//
//  Created by Kurtulus Ahmet on 16.11.2017.
//  Copyright © 2017 Kurtulus Ahmet. All rights reserved.
//

import UIKit

class FeaturedPlaylistsTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ownerLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    func populateView(_ featuredPlaylist:FeaturedPlaylistModel){
        
        thumbnailImageView.heroID = featuredPlaylist.image ?? "image"
        ownerLabel.heroID = featuredPlaylist.ownerName ?? "artist"
        nameLabel.heroID = featuredPlaylist.name ?? "name"
        
        nameLabel.text = featuredPlaylist.name ?? "Unknown"
        ownerLabel.text = featuredPlaylist.ownerName ?? "Unknown"
        thumbnailImageView.fetchImage(forPath: featuredPlaylist.image ?? "")
    }

}
