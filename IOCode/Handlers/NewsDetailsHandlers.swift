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
    public func updateViewDetails(article: Article){
        let imageURL = URL(string: article.urlToImage)
        articleImage.downloadImageFrom(url: imageURL!, imageMode: .scaleAspectFit)
        articleImage.contentMode = .scaleAspectFill
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, h:mm a"
        articleDate.text = dateFormatter.string(from: article.dateSystem)
        articleTitle.text = article.title
        articleDescription.text = article.content
        //        resourceImage
        //        resourceName
    }
    
    
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
            UIApplication.shared.open(url, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
}
