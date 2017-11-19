//
//  ServiceManager.swift
//  RxSpotify
//
//  Created by Kurtulus Ahmet on 15.11.2017.
//  Copyright © 2017 Kurtulus Ahmet. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ServiceManager {
    
    static var sharedInstance = ServiceManager()
    
    let defaults = UserDefaults.standard
    
    private var auth: String = {
        return String(format: "%@:%@", Constants.Config.clientID, Constants.Config.clientSecret)
    }()
    
    private var token: String?
    private var nextPage: String?
    
    func getSpotifyAuth(completion: (() -> ())?) {
        if let data = auth.data(using: .utf8) {
            
            let base = data.base64EncodedString()
            
            Alamofire.request(Constants.Network.authUrl, method: .post, parameters: ["grant_type" : "client_credentials"],
                    headers: ["Authorization" : "Basic \(base)"]).responseJSON {(response:DataResponse<Any>) in
                    
                    switch(response.result) {
                    case .success(let value):
                        print(value)
                        
                        if let result = response.result.value {
                            let resultDictionary = result as! NSDictionary
                            if let token = resultDictionary["access_token"] as? String {
                                self.defaults.set(token, forKey: "access_token")
                                completion?()
                            }
                            
                        }
                        break
                        
                    case .failure(let error):
                        print(error)
                        completion?()
                        break
                    }
            }
            
        } else {
            print("error to convert auth string to data")
        }
    }
    
    func getReleases(paramaters : [String : Any], completion: @escaping (_ releases : [ReleaseModel], _ error : Error?) -> Void) {
        
        if let access_token = defaults.string(forKey: "access_token") {
            Alamofire.request(Constants.Network.baseUrl + Constants.ApiLookUp.newReleases, method: .get, parameters: paramaters, encoding: URLEncoding.default, headers: ["Authorization" : "Bearer \(access_token)"]).responseJSON { (response) in
                
                if response.result.value != nil {
                    let json = JSON(response.result.value!)
                    print("JSON : \(json)")
                    
                    var releases : [ReleaseModel] = []
                    
                    releases = self.convertReleaseModelJson(json)
                    
                    completion(releases,response.error)
                } else {
                    let releases : [ReleaseModel] = []
                    completion(releases,response.error)
                }
            }
        }else {
            let releases : [ReleaseModel] = []
            completion(releases,CustomError.notFoundUserDefaultError)
        }
    }
    
    func getFeaturedPlaylists(paramaters : [String : Any], completion: @escaping (_ featuredPlaylists : [FeaturedPlaylistModel], _ error : Error?) -> Void) {
        
        if let access_token = defaults.string(forKey: "access_token") {
            Alamofire.request(Constants.Network.baseUrl + Constants.ApiLookUp.featuredPlaylists, method: .get, parameters: paramaters, encoding: URLEncoding.default, headers: ["Authorization" : "Bearer \(access_token)"]).responseJSON { (response) in
                
                if response.result.value != nil {
                    let json = JSON(response.result.value!)
                    print("JSON : \(json)")
                    
                    var featuredPlaylists : [FeaturedPlaylistModel] = []
                    
                    featuredPlaylists = self.convertFeaturedPlaylistModelJson(json)
                    
                    completion(featuredPlaylists,response.error)
                } else {
                    let featuredPlaylists : [FeaturedPlaylistModel] = []
                    completion(featuredPlaylists,response.error)
                }
            }
        }else {
            let featuredPlaylists : [FeaturedPlaylistModel] = []
            completion(featuredPlaylists,CustomError.notFoundUserDefaultError)
        }
    }
    
    private func convertReleaseModelJson(_ json: JSON) -> [ReleaseModel]
    {
        var releases: [ReleaseModel] = []
        
        for (_, item):(String,JSON) in json["albums"]["items"] {
            
            let name = item["name"].string
            let artistsName = retrieveArtists(item["artists"])
            
            var thumbnail: String?
            var fullImage: String?
            
            if let images = item["images"].array {
                
                thumbnail = images[2]["url"].string
                fullImage = images[0]["url"].string
            }
            
            let url: String? = item["external_urls"]["spotify"].string
            
            let release = ReleaseModel(name,
                                       artistsName,
                                       thumbnail,
                                       fullImage,
                                       url
            )
            
            releases.append(release)
            
        }
        
        return releases
    }
    
    private func convertFeaturedPlaylistModelJson(_ json: JSON) -> [FeaturedPlaylistModel]
    {
        var releases: [FeaturedPlaylistModel] = []
        
        for (_, item):(String,JSON) in json["playlists"]["items"] {
            
            let name = item["name"].string
            let ownerName = item["owner"]["display_name"].string
            
            var fullImage: String?
            
            if let images = item["images"].array {
                fullImage = images[0]["url"].string
            }
            
            let url: String? = item["external_urls"]["spotify"].string
            
            let release = FeaturedPlaylistModel(name,
                                       ownerName,
                                       fullImage,
                                       url
            )
            
            releases.append(release)
            
        }
        
        return releases
    }
    
    /// A release can have more than one artist
    /// so we iterate through them appending with the characere &
    private func retrieveArtists(_ artists:JSON) -> String?
    {
        var artistsName: String?
        
        for (_,artist): (String, JSON) in artists {
            
            if let name = artist["name"].string {
                if artistsName == nil {
                    artistsName = name
                } else {
                    artistsName = artistsName?.appending(" & \(name)")
                }
            }
        }
        
        return artistsName
    }
    
    private func retrieveOwners(_ artists:JSON) -> String?
    {
        var artistsName: String?
        
        for (_,artist): (String, JSON) in artists {
            
            if let name = artist["name"].string {
                if artistsName == nil {
                    artistsName = name
                } else {
                    artistsName = artistsName?.appending(" & \(name)")
                }
            }
        }
        
        return artistsName
    }
}
