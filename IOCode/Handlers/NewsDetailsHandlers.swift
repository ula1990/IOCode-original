//
//  NewsDetailsHandlers.swift
//  IOCode
//
//  Created by Uladzislau Daratsiuk on 10/10/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import Foundation
import UIKit

extension NewsDetailsVC {
    @objc public func handleShare(){
        let activityVC = UIActivityViewController(activityItems: ["That's interesting news \(currentArticle!.url)"], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: nil)
    }
    
    @objc public func handleLink(){
        guard let url = URL(string: receivedArticle!.url) else {
            return
        }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
}
