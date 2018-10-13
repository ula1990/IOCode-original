//
//  DeveloperModel.swift
//  IOCode
//
//  Created by Uladzislau Daratsiuk on 9/18/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import Foundation
import UIKit

class Developer: NSObject {
    let profileImage: String
    let name: String
    let title: String
    let descriptionInfo: String
    let siteUrl: String
    let patreonUrl: String
    let youtubeUrl: String
    let twitterUrl: String
    let instagramUrl: String
    
    init(profileImage: String,name: String, title: String, descriptionInfo: String,siteUrl: String,patreonUrl: String,youtubeUrl: String,twitterUrl: String,instagramUrl: String) {
        self.profileImage = profileImage
        self.name = name
        self.title = title
        self.descriptionInfo  = descriptionInfo
        self.siteUrl = siteUrl
        self.patreonUrl = patreonUrl
        self.youtubeUrl = youtubeUrl
        self.twitterUrl = twitterUrl
        self.instagramUrl = instagramUrl
    }
    
}
