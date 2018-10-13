//
//  AboutVCHandlers.swift
//  IOCode
//
//  Created by Uladzislau Daratsiuk on 10/12/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import Foundation
import UIKit

extension AboutVC {
    @objc public func openButtonUrl(urlStr:String!) {
        if let url = NSURL(string:urlStr) {
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }
    
    @objc public func handleTwitter(){
        openButtonUrl(urlStr: "https://twitter.com/daratsiuk")
    }
    
    @objc public func handlePatreon(){
        openButtonUrl(urlStr: "https://www.patreon.com/ula")
    }
    
    @objc public func handleSlack(){
        openButtonUrl(urlStr: "https://iosdeveloperula.slack.com/")
    }
}
