//
//  ViewController.swift
//  RxSpotify
//
//  Created by Kurtulus Ahmet on 15.11.2017.
//  Copyright © 2017 Kurtulus Ahmet. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        ServiceManager.sharedInstance.getSpotifyAuth {
            print("login başarılı")
            let releaseVC = self.storyboard?.instantiateViewController(withIdentifier: "home")
            self.present(releaseVC!, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

