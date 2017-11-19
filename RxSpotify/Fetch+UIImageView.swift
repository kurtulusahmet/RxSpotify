//
//  Fetch+UIImageView.swift
//  RxSpotify
//
//  Created by Kurtulus Ahmet on 16.11.2017.
//  Copyright © 2017 Kurtulus Ahmet. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func fetchImage(forPath path: String) {
        
        if let url =  URL(string: path) {
            DispatchQueue.global(qos: .userInitiated).async {
                
                let contentOfURL = NSData(contentsOf: url)
                DispatchQueue.main.async {
                    [weak self] in
                    
                    if let imageData = contentOfURL {
                        self?.image = UIImage(data: imageData as Data)
                    }
                }
            }
        }
    }
}
