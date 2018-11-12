//
//  CommunityVCHandlers.swift
//  IOCode
//
//  Created by Uladzislau Daratsiuk on 9/18/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import Foundation
import UIKit

extension CommunityVC {
    
    public func createDevArray() -> [Developer] {
        var tempArray = [Developer]()
        let dev1 = Developer(profileImage: "seanAllen", name: "Sean Allen", title: "Youtuber & iOS Developer", descriptionInfo: "Self-taught iOS Engineer with 3+ years experience. He spent the first 1.5 years of his career leading client side development for a small startup in Silicon Valley, and have been living the independent contractor life ever since", siteUrl: "http://seanallen.co", patreonUrl: "https://www.patreon.com/seanallen", youtubeUrl: "https://www.youtube.com/channel/UCbTw29mcP12YlTt1EpUaVJw", twitterUrl: "https://twitter.com/seanallen_dev", instagramUrl: "https://www.instagram.com/seanallen_dev/")
        let dev2 = Developer(profileImage: "markMoeykens",name: "Mark Moeykens", title: "Youtuber & iOS Developer", descriptionInfo: "Mobile Development YouTube.Experienced iOS Developer, Mentor and Educator with a demonstrated history of working in multiple industries.", siteUrl: "http://swiftquickstart.blogspot.com/", patreonUrl: "https://www.patreon.com/bigmountainstudio", youtubeUrl: "https://www.youtube.com/markmoeykens", twitterUrl: "https://twitter.com/bigmtnstudio", instagramUrl: "https://www.instagram.com/mjmoeykens/")
        let dev3 = Developer(profileImage: "brianVoong", name: "Brian Voong", title: "Youtuber & iOS Developer", descriptionInfo: "I'll do my best to teach you how to build working apps from the AppStore, i.e. YouTube, Facebook, FB Messenger, etc.  We go beyond making simple blog and calculator apps to explore how professionals create million dollar projects.", siteUrl: "https://www.letsbuildthatapp.com", patreonUrl: "", youtubeUrl: "https://www.youtube.com/channel/UCuP2vJ6kRutQBfRmdcI92mA", twitterUrl: "https://twitter.com/buildthatapp", instagramUrl: "https://www.instagram.com/buildthatapp/")
        
        tempArray.append(dev1)
        tempArray.append(dev2)
        tempArray.append(dev3)
        
        return tempArray
    }
    
    @objc public func handleAbout(){
        let vc = AboutVC()
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
}
